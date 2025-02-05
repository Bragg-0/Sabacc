#include "..\script_macro.hpp"

params [["_GameNumber", -1, [0]], ["_playerNumber", -1, [0]], ["_bonusNumber", 0, [0]]];

private _bonus = getPlayerBonus(_GameNumber, _playerNumber, _bonusNumber);

private _canUseBonus = _bonus select 1;

if (_canUseBonus == false) exitWith {};

private _bonusType = _bonus select 0;

switch (_bonusType) do {
	case 1: {}; // TODO - Remboursement supplémentaire : Récupérez 3 jetons.

	case 2: {}; // TODO - Audit : Choisissez un joueur qui a au moins 3 jetons de mise. Il doit payer une taxe de 3 jetons de mise.

	case 3: {}; // TODO - Grosse arnaque : Fixez la valeur de l’imposteur à 6 jusqu’à la prochaine révélation.

	case 4: {}; // TODO - Transaction directe : Choisissez un joueur et échangez vos cartes avec lui.

	case 5: {}; // TODO - Réduction : La valeur du sylop est fixée à 0 jusqu’à la prochaine révélation.

	case 6: {}; // TODO - Embargo : Le prochain joueur doit passer son tour.

	case 7: {}; // TODO - Détournement de fonds : Prenez 1 jeton dans le pot de chaque joueur et ajoutez-les à votre pot.

	case 8: {}; // TODO - Tirage gratuit : Ignorez le coût pour tirer une carte à ce tour

	case 9: {}; // TODO - Immunité : Les Bonus n’ont pas d’effet sur vous jusqu'à la prochaine révélation.

	case 10: {}; // TODO - Raid : Les autres joueurs en position de tenir doivent payer une taxe de 2 jetons de mise.

	case 11: {}; // TODO - Régulation : Les autres joueurs doivent payer une taxe de 1 jeton de mise.

	case 12: {}; // TODO - Remboursement : Récupérez 2 jetons

	case 13: {}; // TODO - Réévaluation : Lancez 2 dés. Choisissez un résultat comme dernière main la plus forte de Sabacc.

	case 14: {}; // TODO - Droit spécial : Choisissez un joueur. Il doit payer une taxe de 2 jetons de mise.

	case 15: {}; // TODO - Fraude comptable : La force des mains de Sabacc est inversée jusqu’à la prochaine révélation.

	case 16: {}; // TODO - Epuisement : Choisissez un joueur. Il doit défausser sa main et piocher à nouveau.

	default {}; // Vide
};