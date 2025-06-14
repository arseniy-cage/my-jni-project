#include "main.h"
#include "gui/gui.h"
#include "game/game.h"
#include "net/netgame.h"
#include "dialog.h"
#include "GButton.h"
#include "scoreboard.h"
#include "keyboard.h"

#include "settings.h"

extern CGUI * pGUI;
extern CGame* pGame;
extern CNetGame* pNetGame;
extern CDialogWindow* pDialogWindow;
extern CScoreBoard* pScoreBoard;
extern CKeyBoard* pKeyBoard;
extern CSettings* pSettings;

CGButton::CGButton()
{
	LoadTextureButton();
}

CGButton::~CGButton()
{

}

void CGButton::LoadTextureButton()
{
	p_GButtonTexture = (RwTexture*)LoadTextureFromDB("samp", "gtexture");
}

void CGButton::RenderButton()
{
	if(pScoreBoard->m_bToggle || pKeyBoard->IsOpen()) return;
	
	if(!pNetGame) return;
	if(pNetGame->GetGameState() != GAMESTATE_CONNECTED) return;
	
	ImGuiIO &io = ImGui::GetIO();
	
	ImGui::SetNextWindowPos(ImVec2(250, 250));
	
	ImGui::PushStyleColor(ImGuiCol_Button, (ImVec4)ImColor(0x00, 0x00, 0x00, 0x00).Value);
	ImGui::PushStyleColor(ImGuiCol_ButtonHovered, (ImVec4)ImColor(0x00, 0x00, 0x00, 0x00).Value);
	ImGui::PushStyleColor(ImGuiCol_ButtonActive, (ImVec4)ImColor(0x00, 0x00, 0x00, 0x00).Value);
	
	ImGuiStyle style;
	style.FrameBorderSize = ImGui::GetStyle().FrameBorderSize;
	ImGui::GetStyle().FrameBorderSize = 0.0f;
	
	ImGui::Begin("Passenger", nullptr, ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoMove | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoSavedSettings);
	
	ImVec2 vecButSize_g = ImVec2(pGUI->ScaleY(150), pGUI->ScaleY(150));
	
	CPlayerPed *pPlayerPed = pGame->FindPlayerPed();
	if(!pPlayerPed->IsInVehicle() && !pPlayerPed->IsAPassenger())
	{
		CVehiclePool *pVehiclePool = pNetGame->GetVehiclePool();
		if(pVehiclePool)
		{
			uint16_t sNearestVehicleID = pVehiclePool->FindNearestToLocalPlayerPed();

			CVehicle *pVehicle = pVehiclePool->GetAt(sNearestVehicleID);
			if(pVehicle)
			{
				if(pVehicle->GetDistanceFromLocalPlayerPed() < 7.0f)
				{
					CPlayerPool *pPlayerPool = pNetGame->GetPlayerPool();
					if(pPlayerPool)
					{
						CLocalPlayer *pLocalPlayer = pPlayerPool->GetLocalPlayer();
						if(pLocalPlayer)
						{
							if(!pLocalPlayer->IsSpectating())
							{
								if(ImGui::ImageButton((ImTextureID)p_GButtonTexture->raster, vecButSize_g))
								{
									pPlayerPed->EnterVehicle(pVehicle->m_dwGTAId, true);
									pLocalPlayer->SendEnterVehicleNotification(sNearestVehicleID, true);
								}
							}
						}
					}
				}
			}
		}
	}
	
	ImGui::SetWindowSize(ImVec2(-1, -1));

	ImVec2 dSize    = io.DisplaySize;
	ImVec2 winPos   = ImVec2(dSize.x - (dSize.x / 4), dSize.y / 3);

	ImGui::SetWindowPos(winPos);
	ImGui::End();
	
	ImGui::PopStyleColor(3);
	ImGui::GetStyle().FrameBorderSize = style.FrameBorderSize;
}


