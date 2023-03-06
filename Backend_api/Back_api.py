import json
import numpy as np
from flask import Flask, request
import requests
import pickle

app = Flask(__name__)
model = pickle.load(open('model.pkl', 'rb'))

output = ""


@app.route('/', methods=['GET', 'POST'])
def predict():
    if(request.method == 'POST'):
        global output
        request_data = request.data
        request_data = json.loads(request_data.decode('Utf-8'))
        itching = int(request_data['itching'])
        skin_rash = request_data['skin_rash']
        nodal_skin_eruptions = request_data['nodal_skin_eruptions']
        continuous_sneezing = request_data['continuous_sneezing']
        shivering = request_data['shivering']
        chills = request_data['chills']
        joint_pain = request_data['joint_pain']
        stomach_pain = request_data['stomach_pain']
        acidity = request_data['acidity']
        ulcers_on_tongue = int(request_data['ulcers_on_tongue'])
        muscle_wasting = int(request_data['muscle_wasting'])
        vomiting = int(request_data['vomiting'])
        burning_micturition = int(request_data['burning_micturition'])
        spotting_urination = int(request_data['spotting_urination'])
        fatigue = int(request_data['fatigue'])
        weight_gain = int(request_data['weight_gain'])
        anxiety = int(request_data['anxiety'])
        cold_hands_and_feets = int(request_data['cold_hands_and_feets'])
        mood_swings = int(request_data['mood_swings'])
        weight_loss = int(request_data['weight_loss'])
        restlessness = int(request_data['restlessness'])
        lethargy = int(request_data['lethargy'])
        patches_in_throat = int(request_data['patches_in_throat'])
        irregular_sugar_level = int(request_data['irregular_sugar_level'])
        cough = int(request_data['cough'])
        high_fever = int(request_data['high_fever'])
        sunken_eyes = int(request_data['sunken_eyes'])
        breathlessness = int(request_data['breathlessness'])
        sweating = int(request_data['sweating'])
        dehydration = int(request_data['dehydration'])
        indigestion = int(request_data['indigestion'])
        headache = int(request_data['headache'])
        yellowish_skin = int(request_data['yellowish_skin'])
        dark_urine = int(request_data['dark_urine'])
        nausea = int(request_data['nausea'])
        loss_of_appetite = int(request_data['loss_of_appetite'])
        pain_behind_the_eyes = int(request_data['pain_behind_the_eyes'])
        back_pain = int(request_data['back_pain'])
        constipation = int(request_data['constipation'])
        abdominal_pain = int(request_data['abdominal_pain'])
        diarrhoea = int(request_data['diarrhoea'])
        mild_fever = int(request_data['mild_fever'])
        yellow_urine = int(request_data['yellow_urine'])
        yellowing_of_eyes = int(request_data['yellowing_of_eyes'])
        acute_liver_failure = int(request_data['acute_liver_failure'])
        fluid_overload = int(request_data['fluid_overload'])
        swelling_of_stomach = int(request_data['swelling_of_stomach'])
        swelled_lymph_nodes = int(request_data['swelled_lymph_nodes'])
        malaise = int(request_data['malaise'])
        blurred_and_distorted_vision = int(
            request_data['blurred_and_distorted_vision'])
        phlegm = int(request_data['phlegm'])
        throat_irritation = int(request_data['throat_irritation'])
        redness_of_eyes = int(request_data['redness_of_eyes'])
        sinus_pressure = int(request_data['sinus_pressure'])
        runny_nose = int(request_data['runny_nose'])
        congestion = int(request_data['congestion'])
        chest_pain = int(request_data['chest_pain'])
        weakness_in_limbs = int(request_data['weakness_in_limbs'])
        fast_heart_rate = int(request_data['fast_heart_rate'])
        pain_during_bowel_movements = int(
            request_data['pain_during_bowel_movements'])
        pain_in_anal_region = int(request_data['pain_in_anal_region'])
        bloody_stool = int(request_data['bloody_stool'])
        irritation_in_anus = int(request_data['irritation_in_anus'])
        neck_pain = int(request_data['neck_pain'])
        dizziness = int(request_data['dizziness'])
        cramps = int(request_data['cramps'])
        bruising = int(request_data['bruising'])
        obesity = int(request_data['obesity'])
        swollen_legs = int(request_data['swollen_legs'])
        swollen_blood_vessels = int(request_data['swollen_blood_vessels'])
        puffy_face_and_eyes = int(request_data['puffy_face_and_eyes'])
        enlarged_thyroid = int(request_data['enlarged_thyroid'])
        brittle_nails = int(request_data['brittle_nails'])
        swollen_extremeties = int(request_data['swollen_extremeties'])
        excessive_hunger = int(request_data['excessive_hunger'])
        extra_marital_contacts = int(request_data['extra_marital_contacts'])
        drying_and_tingling_lips = int(
            request_data['drying_and_tingling_lips'])
        slurred_speech = int(request_data['slurred_speech'])
        knee_pain = int(request_data['knee_pain'])
        hip_joint_pain = int(request_data['hip_joint_pain'])
        muscle_weakness = int(request_data['muscle_weakness'])
        stiff_neck = int(request_data['stiff_neck'])
        swelling_joints = int(request_data['swelling_joints'])
        movement_stiffness = int(request_data['movement_stiffness'])
        spinning_movements = int(request_data['spinning_movements'])
        loss_of_balance = int(request_data['loss_of_balance'])
        unsteadiness = int(request_data['unsteadiness'])
        weakness_of_one_body_side = int(
            request_data['weakness_of_one_body_side'])
        loss_of_smell = int(request_data['loss_of_smell'])
        bladder_discomfort = int(request_data['bladder_discomfort'])
        foul_smell_of_urine = int(request_data['foul_smell_of_urine'])
        continuous_feel_of_urine = int(
            request_data['continuous_feel_of_urine'])
        passage_of_gases = int(request_data['passage_of_gases'])
        internal_itching = int(request_data['internal_itching'])
        toxic_look_typhos = int(request_data['toxic_look_typhos'])
        depression = int(request_data['depression'])
        irritability = int(request_data['irritability'])
        muscle_pain = int(request_data['muscle_pain'])
        altered_sensorium = int(request_data['altered_sensorium'])
        red_spots_over_body = int(request_data['red_spots_over_body'])
        belly_pain = int(request_data['belly_pain'])
        abnormal_menstruation = int(request_data['abnormal_menstruation'])
        dischromic_patches = int(request_data['dischromic_patches'])
        watering_from_eyes = int(request_data['watering_from_eyes'])
        increased_appetite = int(request_data['increased_appetite'])
        polyuria = int(request_data['polyuria'])
        family_history = int(request_data['family_history'])
        mucoid_sputum = int(request_data['mucoid_sputum'])
        rusty_sputum = int(request_data['rusty_sputum'])
        lack_of_concentration = int(request_data['lack_of_concentration'])
        visual_disturbances = int(request_data['visual_disturbances'])
        receiving_blood_transfusion = int(
            request_data['receiving_blood_transfusion'])
        receiving_unsterile_injections = int(
            request_data['receiving_unsterile_injections'])
        coma = int(request_data['coma'])
        stomach_bleeding = int(request_data['stomach_bleeding'])
        distention_of_abdomen = int(request_data['distention_of_abdomen'])
        history_of_alcohol_consumption = int(
            request_data['history_of_alcohol_consumption'])
        fluid_overload2 = int(request_data['fluid_overload2'])
        blood_in_sputum = int(request_data['blood_in_sputum'])
        prominent_veins_on_calf = int(request_data['prominent_veins_on_calf'])
        palpitations = int(request_data['palpitations'])
        painful_walking = int(request_data['painful_walking'])
        pus_filled_pimples = int(request_data['pus_filled_pimples'])
        blackheads = int(request_data['blackheads'])
        scurring = int(request_data['scurring'])
        skin_peeling = int(request_data['skin_peeling'])
        silver_like_dusting = int(request_data['silver_like_dusting'])
        small_dents_in_nails = int(request_data['small_dents_in_nails'])
        inflammatory_nails = int(request_data['inflammatory_nails'])
        blister = int(request_data['blister'])
        red_sore_around_nose = int(request_data['red_sore_around_nose'])
        yellow_crust_ooze = int(request_data['yellow_crust_ooze'])

        input_list = [itching,
                      skin_rash,
                      nodal_skin_eruptions,
                      continuous_sneezing,
                      shivering,
                      chills,
                      joint_pain,
                      stomach_pain,
                      acidity,
                      ulcers_on_tongue,
                      muscle_wasting,
                      vomiting,
                      burning_micturition,
                      spotting_urination,
                      fatigue,
                      weight_gain,
                      anxiety,
                      cold_hands_and_feets,
                      mood_swings,
                      weight_loss,
                      restlessness,
                      lethargy,
                      patches_in_throat,
                      irregular_sugar_level,
                      cough,
                      high_fever,
                      sunken_eyes,
                      breathlessness,
                      sweating,
                      dehydration,
                      indigestion,
                      headache,
                      yellowish_skin,
                      dark_urine,
                      nausea,
                      loss_of_appetite,
                      pain_behind_the_eyes,
                      back_pain,
                      constipation,
                      abdominal_pain,
                      diarrhoea,
                      mild_fever,
                      yellow_urine,
                      yellowing_of_eyes,
                      acute_liver_failure,
                      fluid_overload,
                      swelling_of_stomach,
                      swelled_lymph_nodes,
                      malaise,
                      blurred_and_distorted_vision,
                      phlegm,
                      throat_irritation,
                      redness_of_eyes,
                      sinus_pressure,
                      runny_nose,
                      congestion,
                      chest_pain,
                      weakness_in_limbs,
                      fast_heart_rate,
                      pain_during_bowel_movements,
                      pain_in_anal_region,
                      bloody_stool,
                      irritation_in_anus,
                      neck_pain,
                      dizziness,
                      cramps,
                      bruising,
                      obesity,
                      swollen_legs,
                      swollen_blood_vessels,
                      puffy_face_and_eyes,
                      enlarged_thyroid,
                      brittle_nails,
                      swollen_extremeties,
                      excessive_hunger,
                      extra_marital_contacts,
                      drying_and_tingling_lips,
                      slurred_speech,
                      knee_pain,
                      hip_joint_pain,
                      muscle_weakness,
                      stiff_neck,
                      swelling_joints,
                      movement_stiffness,
                      spinning_movements,
                      loss_of_balance,
                      unsteadiness,
                      weakness_of_one_body_side,
                      loss_of_smell,
                      bladder_discomfort,
                      foul_smell_of_urine,
                      continuous_feel_of_urine,
                      passage_of_gases,
                      internal_itching,
                      toxic_look_typhos,
                      depression,
                      irritability,
                      muscle_pain,
                      altered_sensorium,
                      red_spots_over_body,
                      belly_pain,
                      abnormal_menstruation,
                      dischromic_patches,
                      watering_from_eyes,
                      increased_appetite,
                      polyuria,
                      family_history,
                      mucoid_sputum,
                      rusty_sputum,
                      lack_of_concentration,
                      visual_disturbances,
                      receiving_blood_transfusion,
                      receiving_unsterile_injections,
                      coma,
                      stomach_bleeding,
                      distention_of_abdomen,
                      history_of_alcohol_consumption,
                      fluid_overload2,
                      blood_in_sputum,
                      prominent_veins_on_calf,
                      palpitations,
                      painful_walking,
                      pus_filled_pimples,
                      blackheads,
                      scurring,
                      skin_peeling,
                      silver_like_dusting,
                      small_dents_in_nails,
                      inflammatory_nails,
                      blister,
                      red_sore_around_nose,
                      yellow_crust_ooze]

        final_list = [np.array(input_list)]

        predicted_value = model.predict(final_list)
        output = predicted_value

        return str(output)
    else:
        return str(output)


if __name__ == "__main__":
    app.run()
