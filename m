Return-Path: <linux-efi+bounces-4395-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC8EB07F4B
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369F44E7791
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CE1290BB4;
	Wed, 16 Jul 2025 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ebx3de/x"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D428B3EF
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700078; cv=none; b=WftBevopfEX42Yhl2SaUSGG0QrUDYPWwCuwh4JoIdc2pL6gyzggTNcK8C7KwVYLBTvhdZkVJuItAQkhUl79JSEHccGL0NFwtv2QxQ8hqrgNhJCCFt3FwvqdzQUywlUj7hZBfj3kuT3EaeqHY4RTycRpZYjwftVPTEJxQoD5Cij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700078; c=relaxed/simple;
	bh=LpqAPGefwzBwFYR9r2WmokfPuA0JN8SVJrbGha/EKBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOeGoAEI+RZJ/5Ehjyfw49yZ50Lyz/XEqFoODyDwg71YdR2fPRTvx5mr6INbVCl78wo7zb4SlfrFz3LQONaE/XeoKWVEETb45bjVYMkqzXD0lK8sjcVXP4ea4YIUo+y4oRtrSjcHLgHVqOeN+h3YYWgwcbMgjYFR1fqjliNcU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ebx3de/x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GGDWr4032375
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 21:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZnxKZl2pTILgIyiA7gr+WaJOYDTln2epWNFqVmNyzYs=; b=Ebx3de/xHGD++jog
	Pc6U7f6ruDqeECEmGtpZtUTNBjLOsAtaiisF+o5IVEDC3CQrrgDc+QjPkDUCKQOT
	OyT8A3nAZLcwyBpWmvc7fC+tx3GE92Q4NiisHbcNXxYgCFESKxgeTtib6y6PSnva
	uuFGw0mLJ/90iJd4BlH0sXXyshDqQpUHLrZg09nF79S2V+wnY+cAcP3goTnPHcGD
	E5TydTWfkGJUcgGTg60nMsJFpUW3xz1gYnGYj2Kf4ITRiWbMKGQyGFUlFWe1rRKl
	hPWEAC5xC3icO6paBmVxQWZlvKLEfoMtdAcMNkc/AMUiGiXdLb/+l1TsBGFSUWpt
	Ml9b2g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ug385fww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 21:07:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e348600cadso31070085a.3
        for <linux-efi@vger.kernel.org>; Wed, 16 Jul 2025 14:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700075; x=1753304875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnxKZl2pTILgIyiA7gr+WaJOYDTln2epWNFqVmNyzYs=;
        b=JZWnu9VxCacRWbrzRnTU4cHI5Lh93iNjih91DlrpgfzFjgoV+Q+IgLQ5IqewAo3YnG
         0LnFYy5Hyvwct6A9zyd7Wg1DeAxiMknYnKHxDTKKQsB7BVekPlu1UTub4kS+wyXLO3Ta
         U5aiimySWRogiXL+51ehBYeldrghCDp366dWTn1VoV8TstiGr0RAHVcR2C9adfn1CAWW
         hGvT+PyjUd8ViLo1axwU1geiAYPTMXHwdie3a/NsI1tku8DhHJHHimJ4bwnyJWgxGyN9
         U3q7dy7wkJMQcxJ2pt21dyX88jDFztlKzx8yl35XioJ1kk95UGetCUHbcOiXX0rHjMC0
         wZoA==
X-Forwarded-Encrypted: i=1; AJvYcCVoGZ5/Yy1Sq2LPrn6Mc4CLv9XifC2nCjPqBIav2qSxNxscgmTPpomSxuAJe/7QFaAZdRcxCQ5J9RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbmwrhTUM+E3nG5DRVNcwTbWtTurRoa5gzMYATyyNPSitT0pl
	khqNmmsoZVINlJKolhECXqlR/zwt/7auj/s+tJ3xeoaHsthz5HkWZRcbkvJbJfap501WPb+nzBZ
	9GtKrVmZintM+pjkisCgDduprXdjM0gS8B8hBO55SpxH9QC3cGdldNdjzn8+1RyI=
X-Gm-Gg: ASbGncsWbRYmmydtw8TcnCjHoj+iwDo7/TjPTXtpD0/qE/lmRNbpgJ2pdF/liDl0Jpc
	VuprOhk63nhpcbM0Ocnpd4DgmcMiSVtyX5RP/1dGjzjZfqZjKLgNouMgBBfGIb8NTMkex2jkGaV
	vgs9gR/fcGlOyNfTe6zuADSVVU3Us2L5V1ap5WAOPqCWOcAg+tdJAaFZkTdB38UW0Nzu3lavZgK
	WNkt49c+GrgT9fF7VDw3xEuEKWcaqm5QuwVpKdHuAOFz1Y87LN5WBSC8ZOG4WTOz3l125r1kBAp
	utw5XY+I4D4KK/Z0sRS4JLayZy+fKVMCEcxXy2Xn13ux1GPED4AA7kQ64yuFahIMvyVEupNh7Mx
	KSD7qKUxBsjvX0/Y=
X-Received: by 2002:a05:620a:2b48:b0:7e0:9b88:133f with SMTP id af79cd13be357-7e342b6a6aamr555188485a.39.1752700074564;
        Wed, 16 Jul 2025 14:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqgyZt//7oK1PvV9G4wGP6jOLAP5TEppBWiJSWJsoBpj047J7aylcwmETAAX26ToFCZHeUQw==
X-Received: by 2002:a05:620a:2b48:b0:7e0:9b88:133f with SMTP id af79cd13be357-7e342b6a6aamr555182485a.39.1752700073880;
        Wed, 16 Jul 2025 14:07:53 -0700 (PDT)
Received: from [10.143.245.182] (87-95-12-98.bb.dnainternet.fi. [87.95.12.98])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bb661sm2798793e87.10.2025.07.16.14.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 14:07:52 -0700 (PDT)
Message-ID: <50029df9-a317-4341-99a8-8e55b8ae4aea@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 00:07:52 +0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] firmware: qcom: uefisecapp: add support for R/O
 UEFI vars
To: Bjorn Andersson <andersson@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-3-aacca9306cee@oss.qualcomm.com>
 <4ylx7fxgwozm4yaavltlq6disd54acm3iko6tte2rxhufgq6rj@scwldtfbelg6>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <4ylx7fxgwozm4yaavltlq6disd54acm3iko6tte2rxhufgq6rj@scwldtfbelg6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE5MCBTYWx0ZWRfX0HgzIL+twajM
 MRD+ycxsfQd2Gc5QGSwf5PsG6FXUoxAredVSJRBO3/z1mcLYV0SYtTY8nNh5XoF9+qdmvpbgXAk
 U4bKlf4L43GY6Zj8uUAig3pi4fInl+KLsREptToIjbjW1w9vTqv4t5CRrKjJ3LeZVWKKtpX/QVY
 KGxWTN2Z8i5yqVDLJYx0LrcBen3nzo5w3zctodqNCIdu9gaEx+y58Fvcao/6aYnr4hLio/OZQyX
 IE0A0vLaWdakuP8pLmJt43+4IYaNul+AP/p3OeZ2A6QjVrQ4bx2/EeYK3SIfm3ogc5HBde+gdR5
 BkyV0ArDOt40uw5igosfTadR4tgX/vieZ83vC7NmAymqWtQwdUoyt3dPjCLbpfDnxjp3Y8cadky
 cIUoogDZaEB4esTR/tiAOT+D7EFQ2xM68WsmTYJSd3nqun1tgAQYl7dgQdiXdYNYDXLfn32l
X-Proofpoint-GUID: ZsF5NIl436MqY4cyOmriUZ6G7BflT5di
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=687814ab cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=G1XBu1ow44TIBf0dtryxDQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=rBXHhWp4RwpHmD1I-XcA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ZsF5NIl436MqY4cyOmriUZ6G7BflT5di
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_04,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160190

On 16/07/2025 22:13, Bjorn Andersson wrote:
> On Wed, Jun 25, 2025 at 01:53:22AM +0300, Dmitry Baryshkov wrote:
>> For some platforms (e.g. Lenovo Yoga C630) we don't yet know a way to
>> update variables in the permanent storage. However being able to read
>> the vars is still useful as it allows us to get e.g. RTC offset.
>>
>> Add a quirk for QSEECOM specifying that UEFI variables for this platform
>> should be registered in read-only mode.
>>
> 
> In order to implement UEFI variable storage on any device where the OS
> owns the one storage device requires some form of bridge service running
> in the OS.
 > > We should expect that such devices will exist in the future as well 
(due
> to BOM cost) and as such a solution for this will have to present itself
> in a upstream compliant fashion.

Sure.

> 
> There's a lot of infrastructure being introduced here to convey a single
> boolean flag which I'm hoping to be dead code sooner rather than later.


I think we might have more quirks in future, but I'm fine with just 
forcing R/O uefi vars for SDM845 and MSM8998 (I assume SC8180X should 
also have the same issue, but it was enabled unconditionally).


> 
> Now there's some differences in your wording between the patches and the
> responses. In some places you're talking about the C630 crashing, in
> others you describe it as EFI variable writes aren't persistent. That
> makes me wonder if we have two problems, or what you're refering to here
> is just the same problem we see on all UFS-based systems (Qualcomm and
> others).


Those are separate issues:
- C630 doesn't persist variables across reboots
- Enabling R/O UEFI variables uncovers a crash at the rtc_pm8xxx / 
efivars code.


> 
> Regards,
> Bjorn
> 
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/firmware/qcom/qcom_qseecom_uefisecapp.c | 18 +++++++++++++++++-
>>   include/linux/firmware/qcom/qcom_qseecom.h      |  2 ++
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>> index 98a463e9774bf04f2deb0f7fa1318bd0d2edfa49..05f700dcb8cf3189f640237ff0e045564abb8264 100644
>> --- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>> +++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
>> @@ -792,6 +792,12 @@ static efi_status_t qcuefi_query_variable_info(u32 attr, u64 *storage_space, u64
>>   	return status;
>>   }
>>   
>> +static const struct efivar_operations qcom_efivars_ro_ops = {
>> +	.get_variable = qcuefi_get_variable,
>> +	.get_next_variable = qcuefi_get_next_variable,
>> +	.query_variable_info = qcuefi_query_variable_info,
>> +};
>> +
>>   static const struct efivar_operations qcom_efivar_ops = {
>>   	.get_variable = qcuefi_get_variable,
>>   	.set_variable = qcuefi_set_variable,
>> @@ -804,7 +810,9 @@ static const struct efivar_operations qcom_efivar_ops = {
>>   static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>>   				 const struct auxiliary_device_id *aux_dev_id)
>>   {
>> +	unsigned long *quirks = aux_dev->dev.platform_data;
>>   	struct qcom_tzmem_pool_config pool_config;
>> +	const struct efivar_operations *ops;
>>   	struct qcuefi_client *qcuefi;
>>   	int status;
>>   
>> @@ -829,7 +837,15 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
>>   	if (status)
>>   		return status;
>>   
>> -	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
>> +	if (quirks &&
>> +	    *quirks & QCOM_QSEECOM_QUIRK_RO_UEFIVARS) {
>> +		dev_dbg(&aux_dev->dev, "R/O UEFI vars implementation\n");
>> +		ops = &qcom_efivars_ro_ops;
>> +	} else {
>> +		ops = &qcom_efivar_ops;
>> +	}
>> +
>> +	status = efivars_register(&qcuefi->efivars, ops);
>>   	if (status)
>>   		qcuefi_set_reference(NULL);
>>   
>> diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
>> index 3387897bf36843cccd0bd933dd562390bf674b14..8d6d660e854fdb0fabbef10ab5ee6ff23ad79826 100644
>> --- a/include/linux/firmware/qcom/qcom_qseecom.h
>> +++ b/include/linux/firmware/qcom/qcom_qseecom.h
>> @@ -51,4 +51,6 @@ static inline int qcom_qseecom_app_send(struct qseecom_client *client,
>>   	return qcom_scm_qseecom_app_send(client->app_id, req, req_size, rsp, rsp_size);
>>   }
>>   
>> +#define QCOM_QSEECOM_QUIRK_RO_UEFIVARS		BIT(0)
>> +
>>   #endif /* __QCOM_QSEECOM_H */
>>
>> -- 
>> 2.39.5
>>


-- 
With best wishes
Dmitry

