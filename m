Return-Path: <linux-efi+bounces-5519-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB74C5F64F
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 22:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC0B3BD4F9
	for <lists+linux-efi@lfdr.de>; Fri, 14 Nov 2025 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FF35C1A6;
	Fri, 14 Nov 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YiaIGUJ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGeEdt4U"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1B35C18E
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156379; cv=none; b=aLCP1dqUTul1mLYbHy2p8XLZFzTpBc8yemDSXBQepOopMwGIUi5lOOBADtR3lEnN8yTTUulisA3hEsMtdgBi/l5sfU0kXktaA4/ukIZFY4Qc1f7dCTWZJHb0U8/RieCRQCG3AJmySvcHylxbOQ5besTTLqvlOa0l9X1MH+A2q4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156379; c=relaxed/simple;
	bh=ZHS1Ve0lJVsZcUbYN/dn1jMxqM5DQVkG29AZCxZ5bnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKd9vYfytjVwCMRf0ewDQskWquQ44tK7QZNI9QgASk02gN8+grvobh0DEo/7eOKYgFIAC8EC4gZXDb7jkRhpsqvSPNVob3jxs2s5sUVcAndvjBps0X1I8gmgzIcqstuaee9vkr7pflcW8Jc9FnsabIU7aU7oofcErK2mP9uhV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YiaIGUJ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OGeEdt4U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AEIQ3tT517497
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 21:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	otBe/rMrbE1YTzc5bfCsAUJkZyo7ZMz5fnQzamsyzj8=; b=YiaIGUJ8sIqDa5mH
	MG0jFO4LKjhhRJBwxm1RFoJxh0K1+DPExeyc9m+gB547I62ZGJjxpbcgOC4+i0zl
	o42Ma6s0Eu/IuImXYk0NsmScOG8FwXFD6wr/6lq6cnFZ+zKIBtFB7rSHujaRfMDL
	4pO6FC8zjXYIrdO0ybAZwUrREGXhY3+O628IIWfesTdXuVWRNZvU/VVfJfhl8Z+q
	SgZmN5/SYli2AHpGfezNb2V2p6sNjxOfuFei+cI+L3V5X04TyxWG/9oI6WHMBsQj
	wPjVdxAwPbnXPM80JA5DENY9eE8H3LETcjoAih+AqqX6dxKmp5xXQGWGLYG507al
	rNdC+w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ae5r7scr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 21:39:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee0440a771so212071cf.0
        for <linux-efi@vger.kernel.org>; Fri, 14 Nov 2025 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763156376; x=1763761176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otBe/rMrbE1YTzc5bfCsAUJkZyo7ZMz5fnQzamsyzj8=;
        b=OGeEdt4U+3Dr5PpPs2FwGGg09ugzmkq+i7UukWcPuaJXp62z44ABoyUtMjIO8JHEyh
         dI6TikH4bGlFW1IZ2cTj5zvWf/804mAW5z914o/kcNY5Ocm+Jo1ln7UNJsJyxkMWXxIO
         pQlmQHNHHLrC9YQLuC5771KiPfgPi3pRC2BX+EMB/1pnjH8hKAhSq/Q6cCi2bYudxx69
         kLgJ816LzLtfEY5UWpRrm1VOuIcFjbTHCwsw/9ZFbi/PoQ3BRZwVJ8Ewtn7v+sNPDQ4K
         fFxFwOVZeKMijbeaCahft5PVgZvqCiGaQUREwtiSCSM8q/LuwmmDbtzYhWcCD1BiIEUM
         3JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763156376; x=1763761176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otBe/rMrbE1YTzc5bfCsAUJkZyo7ZMz5fnQzamsyzj8=;
        b=G/ajWV1MwPxXs5SMUmC7eOQwoEUlXCIZ6OoWS3fmovBdvvzOnMg/V/aIwU1+M5G4Tk
         Zba4reuuv62HEx8GZkzIHe1xOGcYr8oD4Qd+neClQ8uBWGz7VigS+KkYrqIv9BT77TC/
         vdgYAOZIGuIPClpulO0evq/MiZsmGiCPXFV5B7SAL3ocMtbyT5+rVeDnx+fsPnsIDm4h
         GQ180T0wNSVoNXk1aa31L0Ntp/+c3Y33DUtwpnxxyJT8hMK7Zn4hDA6jHc+n7Q8bUhPV
         Fyw+2qD4V0jLl3FRBCb5xiJCqVehvRjZkGNL/yNPoLC26yClyXRdhDHNlptqpjWMZjE0
         U6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW9dNAMRIBklDAQt8YbdJHDsYWmFHOumpXKtNbVCTSkP5iWnKc+2eMGtogfcLExAZIBwTvD6y8SCtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysH+wGyynalsptD2FEFCwpkUOom+Fgs95eO+xwvI0nVHybWe+q
	SiT05k5+DzLmm/XyTcFy6FH3IkK/hk6LyRocEedOgd35xKsqlgNy567waYF+Ostu8crDwOtnQ1G
	rHHS60hoIhdsW1LWa0gVRDfOQ0+qWBrzGCRfvqqUs7b9pBTDF/3Uk+pos5ZA0veiLALgGUb4=
X-Gm-Gg: ASbGncuC+lGqzrCIsEE2oApM5Ig40EO0d+7EBFrX1+VUO4ZeQ6hCuBN6DQYBdFvveuB
	m19p84LK/0lpESeE5SZw/C3K4i1ra7wSKwRHbq+ytlVSmpZ5S2CVbcR921gLsQM2Ox0VqIS+w7z
	5krgzkVTk99kQxCYE4Q+Jo+/k8Gn61Fj2cb+gHv9UEZhZG3mPqLkFCTe2vjid+aeIAKpAlGqoab
	ioi2/n37l02BYTv3kPBIK0t5Il502CRVnkEk5xrda3H7+5bK8S/YHEcQVt0VBFQM4ML2KCNTVWX
	Uxon/T12m6E/BF0tjgOu341OeZ7jQM9rGiuaVbSEMN7cy08tY0pS17VnO3iXcfMuw370pQJQ+3M
	VeP81JRFvaBXF72OroS9se9zCJGQd2Vnc86vutKQkJD3NMln4EFXm0cYy
X-Received: by 2002:a05:622a:46:b0:4ec:eef1:52f7 with SMTP id d75a77b69052e-4edf372e061mr45325281cf.11.1763156375995;
        Fri, 14 Nov 2025 13:39:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXCq+Z4cf78DQLJIO/O48dRU1rZcKjnoPmpmh32Tu8KqQvjlBSQTN5wBhCxB6vHlVmhvAlJw==
X-Received: by 2002:a05:622a:46:b0:4ec:eef1:52f7 with SMTP id d75a77b69052e-4edf372e061mr45324901cf.11.1763156375548;
        Fri, 14 Nov 2025 13:39:35 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a4b19dcsm4295103a12.27.2025.11.14.13.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 13:39:34 -0800 (PST)
Message-ID: <11ea6680-6aeb-49d7-97de-c44fafcc2e8e@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 22:39:31 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi/reboot: Add support for
 EFI_RESET_PLATFORM_SPECIFIC
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
        mark.rutland@arm.com, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, shivendra.pratap@oss.qualcomm.com,
        leif.lindholm@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20251114085058.2195900-1-sumit.garg@kernel.org>
 <20251114085058.2195900-2-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251114085058.2195900-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDE3NiBTYWx0ZWRfX2ckBe7TeDpyG
 oJFGkg0wexlfGtSfsvTvn+POIMN/PQkYvhSniJZldX8G9DN3sds1wbMfcscicmc3RXr7tUrwaWj
 11hGHAf3PCyAmv21PsIsdr23OaszULa0ipf0vJht8pL85LXkurJOuAED2Jj2bH/lhiTKwsHRS0z
 ILZA1l6H4G78s5+jTP5o8RJq07QDnlkvE5cwqRNEpFYJWF18HHPGESQYF9jKnqKuHdwoGIGSzwp
 eSW5H6ghCmhkm2i5pTV3OIgw37kZ6m1WcnQtGzw5qFo18skzehqxzyEb+MEwHgEjYcVV+WQl3lo
 8aDNxoOIfTy6WGVMo9cWMIQ8EX2JxcFixzsv/O+jwLHZZh3jJu4Q7WKsE7abkU/TjNgZXsyY90F
 hm/TWEeNvJJo9stMXyA4uQ+gq9ZRMg==
X-Proofpoint-ORIG-GUID: ip46vn1LBcboNiQ9gCPHldxDAurRi54h
X-Authority-Analysis: v=2.4 cv=BJO+bVQG c=1 sm=1 tr=0 ts=6917a198 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IJHIyZBPcXzIKyMZlaoA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ip46vn1LBcboNiQ9gCPHldxDAurRi54h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140176

On 11/14/25 9:50 AM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> UEFI specification provides support for EfiResetPlatformSpecific reset
> type as follows:
> 
> "
> ResetSystem:
> 
> Calling this interface with ResetType of EfiResetPlatformSpecific
> causes a system-wide reset. The exact type of the reset is defined
> by the EFI_GUID that follows the Null-terminated Unicode string passed
> into ResetData. If the platform does not recognize the EFI_GUID in
> ResetData the platform must pick a supported reset type to perform.
> The platform may optionally log the parameters from any non-normal
> reset that occurs.
> "
> 
> Lets use the ResetData to pass the platform specific reboot command
> issued and leave it's interpretation to UEFI implementation following
> the specification.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

