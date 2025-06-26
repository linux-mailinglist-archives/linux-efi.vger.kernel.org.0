Return-Path: <linux-efi+bounces-4029-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87865AEAAB2
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 01:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467191C40A9D
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 23:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E882253EE;
	Thu, 26 Jun 2025 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ns6C5b8C"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3FD221FB8
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980902; cv=none; b=psgXahEyuVKFXJ6LSpHu+aWimmrv11NPR2+bOQYUZrdlgYk4z4UmqxpgCPrWV3cf/mXLLw3CE/69q1H/hnrkfalPSQlL51heCuPZDJywp9t0NqjAFbTw+lpZVAzlpMQuwWEossKGN0ZN1bGlbL7FlooMp8Lac2/Em9RTb49E1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980902; c=relaxed/simple;
	bh=9qan4SOQiAV+IvZmYG3SDHvA0EovSnRG2C70bJxoLFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1exXOjJpnhf0gkDXjeAry3u0Z/b5XPoYb2sWpJ1kh5b45Vb08slgbgxT8UwElMZeu5ddjJNEFSmNiboPNPrIemfOCBDcGhDGPEfxfFJPdqaNie2zgo1nonZQycpFHVJv1z5+Dw4qm83rgNq7pYzKhSVkunKzswt1m6Ppu/NY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ns6C5b8C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJx8qk015348
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hAd7DVeEwKm1wjaALp+4bwWbD2AnwwiOE18te0+qjjs=; b=ns6C5b8C5cHhNyBM
	qN8s9Gao8T8QD5IecsR9XxRVP0o8FaiePsCFa8rKbb4USlm8eEjJOdwfku2xR0ms
	pRV/xgB6VPxVMHdPWIRxLrQuOXfmyB9wvmH4imFJUNA2w5LRB5zwB8wlXf9S1Oed
	Q7/Ca1D/jNBC/GzL91hjeQ0l+cg03S8YuH2FoCb4eVetCUZ6Z1sodR4En8TgUpFr
	NVSOIjCf50nA3C5c333LwVDbr2UfUZrr6Wa4iNS3YZ30Gp0/YnL5wXl/FXR6KU/Z
	6uG/DCV3/Y/HiVdh66bJezJ0MdOuu8xHg81PrSj+vyfBI0rpqVCxzgpxDhNlnugO
	DJqwYA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fekxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:34:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d21080c26fso25792885a.1
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 16:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750980899; x=1751585699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAd7DVeEwKm1wjaALp+4bwWbD2AnwwiOE18te0+qjjs=;
        b=fKC8qI9ReOxqCXKrbl7h3CnfrNqew7viGaqactBS5GdlndyWooit+smGFSsfKx/AKU
         VNTt7hfINnS1D5g4Qbgirh/9Ncokmzh5w4qnpO+cdrxxlBzLtb2ZA8hpJJNrdZyk5pag
         To2Rj6DI+tH8dmpqAfDI3NgieBjdXtqii09XID3d/Y1wijMBtI9u1Sch58ZSIT5Bm63B
         1jZQH+raBD86VHJny4YXnjF/9OLJgJIO9lrBxXYOn7lzTQ+w4I9tEeMilaxIgvgfWIOy
         1XeVOTXzzYcPOq2xYLyZbhf+ZFtjhdHZkDI1IR1AVwggFoY/u2Al7zwy6GJjKPl89XuM
         lmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoUdkKKEd4Ij/8DKF143O1N2xkS3AusPK5trr/s5/LEGWzQvhmaigOwbl/J+minYixE1H3pVxwD48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdjhV/+eOGd2IeTpvPPoqKFi1LPVH6yMwHz9zemptL8LWo+sm
	3/noIfB+V8saUk3/V2xAiTLh4po3bRGjDNnpuqC7IAPAAqhWU1Z5iZ78DVwPdDN6soVwrC0OT6i
	iRJ7j4sg2m/arSMyquWMHRPdTz9XQ0dpca9bW+HqnQUWB/LCW5A0WEuuocc1xaqI=
X-Gm-Gg: ASbGncvvi0im2qi4fW6zEiryiCuY5Vf0wCz63nW0fogW6MY7VK3RR+m1Ct1l6WirMHm
	ZxL3cWBlHQgK9R0IRUTE03ZMQx5A715eMCi10Ygf4wTkpl9HZf+eL5XtQWPpWe9x3xODgwNOco0
	xSupW72MRcesEey4FY3CjKjK7cX/ILmqrs1O36w+LPWBhefrEvFYJumKdYs6BWIgq7iUlBXst9M
	IWPJ785U3aKryCLXref5EErJwswrMeJMHjPOLN9vwj6DGyfOd6yUcJIjOvuHEcwjseuPMPIyq4W
	Ilw1iX7srdQpijSSljEcikb7I2okeQ0BBTocJ8ChnD84mLpbH1wCVR3CT1GHtTpTGPD9UFp9bdD
	V+hw=
X-Received: by 2002:a05:620a:172c:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7d4439630ffmr61359385a.4.1750980899105;
        Thu, 26 Jun 2025 16:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2PRBC7jtFvKC0qYTyxR07iUAWipF4qkqzOBUkWOdASYf2yymdYdIveUVPc/yVZg1FF4AV4g==
X-Received: by 2002:a05:620a:172c:b0:7c5:8ece:8b56 with SMTP id af79cd13be357-7d4439630ffmr61357585a.4.1750980898667;
        Thu, 26 Jun 2025 16:34:58 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363a9a8sm15771766b.33.2025.06.26.16.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 16:34:58 -0700 (PDT)
Message-ID: <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 01:34:56 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP
 CRD
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMiBTYWx0ZWRfX2UYoEMu1oPh6
 9DK9v4zqY+RTKBrpadWx5lqkAuHVQyb20V63M3+tOEFMT/5vBL0UgdKNlDfAYDyOxAC1P6OEE/K
 NlwReTCZgCaul22+hkbSwO2kDCojc4/3xRuS/bdsdaOzkCprWbfkm2Kkt8zvxZG1I2iE4rjz1XE
 o28PCUpSOk4d8vuvS1gvUq0hTlA415LdeipnjD3WYBOOU1jzDXV1f7GWQYa2iHWNcqwFs+H+YVv
 Wqkcf9LNoR4k6EVGIx9nDxxntj2CFLJ0NSzpLJeE3/Dfn6W3uVqltyVbiJDeOwL8Cn8f14+u0lD
 M+GZmIXkUDp29oH3mYITGMWpJgegfb/7N/tmNpoXpQLvx2c9w96JawCMy66ysI4YD1QoCihntkt
 bluQ4HkNCdbHZYCZx6g2JYisu3GwFld33vVIDJiJqnlEorsVfYCq2AC96brlHIo/klogMoSi
X-Proofpoint-ORIG-GUID: KrJpFAfoDjWrI5vf9tKtbonfRhlw8OJi
X-Proofpoint-GUID: KrJpFAfoDjWrI5vf9tKtbonfRhlw8OJi
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685dd923 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=UcOP7Zb98ZuMvhyqNpcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260202

On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
> As reported by Johan, this platform also doesn't currently support
> updating of the UEFI variables. In preparation to reworking match list
> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> variables.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index dbb77c3f69ddaa931e7faa73911207a83634bda1..27ef2497089e11b5a902d949de2e16b7443a2ca4 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -2005,6 +2005,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>  	{ .compatible = "microsoft,romulus13", },
>  	{ .compatible = "microsoft,romulus15", },
>  	{ .compatible = "qcom,sc8180x-primus" },
> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },

R/W works for me (tm).. the META version may be (inconclusive) 2605

Konrad

