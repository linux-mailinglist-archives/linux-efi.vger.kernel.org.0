Return-Path: <linux-efi+bounces-4031-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19172AEAAF7
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 01:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480313B6B86
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E1922D4C8;
	Thu, 26 Jun 2025 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ifkrKlJ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CA8227EB9
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750982087; cv=none; b=ViOd2i6dO3u2F92x8txfsoGc5y1TdY6QMN78qgum9MLIp/FfudISTJW2bg6XhHNX5qPqsD1bodo1NOKNGYoKIEJS0bmoYFfCtqISZEK9B3JIDH9wGWYh6Ogqaynsk2ck8aUj3jkJtLgOqWl2F6VxKLoYX1c/I4M7KI8otusWWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750982087; c=relaxed/simple;
	bh=GC3TC7GMidiRgphKPIXpKkHkR9sTB5CRS+p+N4xN+eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn7SrcyI0TSmg3qbZl7ij+s8A3/DyO4rfGGJ4iBMcQCsYPWwUVhho7EbX/yzM4rAt/ixSAOsSPyNfWH/kTlvEw4SA/Pk5Nxz1i8XisqUSfPtKpIquhYQNp1mfqzl/GlLxnUJWJ9DNHCGCnUMHU9DDeGi6vlBXSeF+1pjUztQxeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ifkrKlJ7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJ25PW031223
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fbs4KYNHfJ3NP9WQooBIb3Q8R1VU/MYQIjF+jTKXYVU=; b=ifkrKlJ74yLUM0WX
	G9aGxzH9Q2H2nceFb3l3kaJ1Dq9K6LtOqlLp10EOPUUvWC/KXfVIHLs+ouV29Bms
	sMB8PlAt79Km50zaZjCFf08mgZ9vK50uMZxlswPciPYMX5DCODQfkDN6Fvxo5cFv
	sZnmhud0F1cSwRwUZj1jOnucwCB/pC4BvknUudi3ZUrsx5QGZawpgUa5yWFCc7LZ
	DhMFP8EeynXP4WnwJCVVhNmXSqUpNydFkpHZQno7MvqQTOsGIxJ4XyJWHZ6sl6gz
	90QZ83zC3EY7HURzPJOd0g8F/TSAdW9wuYrZpjkjj9r8S2CY8onZ2C7ewRnGSgUm
	8tckAg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b44t19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 23:54:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d0976a24ceso44755085a.2
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 16:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750982083; x=1751586883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbs4KYNHfJ3NP9WQooBIb3Q8R1VU/MYQIjF+jTKXYVU=;
        b=BlrNh+FBI1yWAfSxeswSZNzwAvL4stn8y1DTRVJB0GOOh4/ko83r+mZ+tSrKIIV9Tx
         QcsipgsUnNUnxxckyfDX8mVzhoRGuo6XDy8CKdVlbIAXGhHBeF5q2WgK9iffVlsuF/Z2
         7toQ5gPoz5orGuFNqzuL6ajyxNXmbvJDWdsegsTjTa0mPpSvhw+EFaDoR872YRh2Wwxe
         pE+vCYOf8dFbvR3NrU00iOLITYyJRJzxfvD9AsgSs5mO9QIVMIcLQKR+Xfsa4dxu93Fp
         5xatBztyJe2HhiA840+F88uBP6N26a0DOcbb8lVp7I1EZvR47n6wnapwfkAqy6iccnqG
         1rrg==
X-Forwarded-Encrypted: i=1; AJvYcCXQqgai4BoFzqiG6LV57YCHv3z3q+gUQrDfd06Di4aL1A5DDTlLmBADR0xhKLxuzOgVvn366/2mn+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzchkJLE2QrIjg+K7wgEXZ9NFeox9EPAdR8CwWvUlL+W+yWyg2r
	cTa0CdPaV0YuR/E2dxEDJaEFpPQ+yEv73iybtrP7rcgc0M3FYvdp8djiJ5oHrfUXgTqVI9eMc2M
	urNNNm9ZjXvbxDX4mNwOquL2E1X/+w7nbXw+k1+owYLlCSeNs2pZAHkDdGaujdAI=
X-Gm-Gg: ASbGncs18GLQ3cz2jEJn74SfZH/f90LMO82JmQgrigRRtKCPRMjxYrTuCeWknv+FR0G
	l/e8o4STXRPrhCA/9+aJUhdiLskKHHI4JBT0JCNlirlRFyOyKB62zOLkH/rnNGagcVmorG8SNEt
	ZT6MJpB6NGbMaLHWmN9h+411joDF5tIg7zm/xQDU4ttQfiZHO+vrmbrjA5m8IxSE+5eWVOsqYZz
	Q+YrpjcPQfuykLLMcNUn1MO9jhXExMA6VMW6yiJxSFq6gjC6/PDlkixgRfHeGdnmD1+CejW86oG
	GElyekSl+nncYCt/3OBJLN2Y3uECk/ZlCmyq5lL0b3ewqr+5fu0sgGRvhu/Pa0lKwventUkNw4r
	8dMk=
X-Received: by 2002:a05:620a:17a0:b0:7d0:986d:963 with SMTP id af79cd13be357-7d4439a5ef4mr80105285a.9.1750982082623;
        Thu, 26 Jun 2025 16:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZvQe0I94SfbVb+8u+GjBJSQrO+fR99SDvM1ofMBXxhAK7dEqWNc0BrbxupoF6oexwLClKFQ==
X-Received: by 2002:a05:620a:17a0:b0:7d0:986d:963 with SMTP id af79cd13be357-7d4439a5ef4mr80100785a.9.1750982080321;
        Thu, 26 Jun 2025 16:54:40 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353659efbsm17829066b.46.2025.06.26.16.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 16:54:39 -0700 (PDT)
Message-ID: <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 01:54:37 +0200
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
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwNSBTYWx0ZWRfX5SusQAw2pnQs
 xufQf2Wj/Ud0Gqct/xXtv6fRJkU7EwDG5ICEXbpaJ+QyxuOBZo099DjqPEOhZRz6TTPv++fOmDL
 1w5YJ1Kq4mhk76kRz7OQWTIuKiOPvWdR/RbFl5Ryrj9GpE6NNrTIT+2vCYt/tPAtZWyKXW0Tnv8
 k5rdS0hFLejsD7gGLBzp+iumNhqArz1VzxUHcoO+Dlred240hnCkfsT8AerOezpuvO6MS30Ct/0
 eIXZ7XTLyrAsBwqbaOy7vjYspqFhBx4N1hUpOupu93dJShrJiJqwT6tBTg2Ix1f244+1jkIFilI
 Cl6scUNYb64BSXt/by1J4RANVuAFjncA3unkXUypx84bs4sZXD6Ae0oyfdngiW94do+SIKx8wH0
 fTopm7+4p/zxp6OGZI83mW79etrx5kxVbfwrjZaieP7FPswHoKRZkNhZGcWFTrJlc3C4VIMq
X-Proofpoint-ORIG-GUID: 4P3Zu5VRU7byAs6fAlb8yAW39SpS0V9y
X-Proofpoint-GUID: 4P3Zu5VRU7byAs6fAlb8yAW39SpS0V9y
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685dddc4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=qZF0ikmejsFuwZQdFt0A:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260205

On 6/27/25 1:34 AM, Konrad Dybcio wrote:
> On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
>> As reported by Johan, this platform also doesn't currently support
>> updating of the UEFI variables. In preparation to reworking match list
>> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
>> variables.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>  drivers/firmware/qcom/qcom_scm.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index dbb77c3f69ddaa931e7faa73911207a83634bda1..27ef2497089e11b5a902d949de2e16b7443a2ca4 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -2005,6 +2005,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>>  	{ .compatible = "microsoft,romulus13", },
>>  	{ .compatible = "microsoft,romulus15", },
>>  	{ .compatible = "qcom,sc8180x-primus" },
>> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> 
> R/W works for me (tm).. the META version may be (inconclusive) 2605

Looked at the wrong SoC META table.. the build date is 05/25/2023

Konrad

