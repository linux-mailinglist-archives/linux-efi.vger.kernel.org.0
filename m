Return-Path: <linux-efi+bounces-3953-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CF6AE65A8
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ACC1887005
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 12:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A16E29A301;
	Tue, 24 Jun 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o4tnesdl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736CE293C6C
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769640; cv=none; b=pPLcA9UbcfNfCqlk7G3Ry4M+vWfOOw7Zwy+Wqcv4mussrcDmwQSGUJxPITgLvgAjKQWAePnBOJ4/p2dp8jMp3/xVv0mUQOYXD6aAsFtzqx3r4N9EnNAsrxsvw+lhQt9mxZJJSV5sLxMdEqw2HwOv94rrV3Fm6XLP9djxSLzmo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769640; c=relaxed/simple;
	bh=tNIhnvuJL34DWyW0/9wKkWvSs2dn5yOqIFqGyBcGiyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jH+yWO0oid4o14UUfgAvBky5wUdzbT4PmY7NL/JHv+BUUr5MWZpdgpvdwylEejZ8/VzkJ+ajYPce/fd6g+znpSm4ShQdBOWud2cyA8Sxhp1RjCzg2ZHWBaU01FdUw72OGqSRQK3s6cbF/gpHR9uPapG3pbJPM62tZQ08q5OVLoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o4tnesdl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O71vMq020990
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aeRBeFnF4lcno5Yc+pip1PsV/E+s7JmR6bAmZl2QfIw=; b=o4tnesdlmoD3y7mR
	b6XNGNjqo0V7b/+TfJAN+ogKd3ncfjFkTcV15lfI3p9oIMlYcQIUK86QLPJ+TJT4
	8Q1UpadV094/L0EcG+k2MxAR+dmqUN1bfngUhDMHwMluNioGvcgDWnHeOPkObIBO
	TaKiTdtyp4gCQNnA+Vd3jtLnrixgtxaUlN+reItPQHSKLk0OIpWrvEylFNnHeQFN
	icUGN6iRk6xrQ30gHkx5FmiT/eQuZfx5NQS+5u4HVaapNtqaO0ILpQLEtFioDsES
	VkDZ2FbUJgPRkUAh65jOHiUCkNycO2vcvRiBvLMYp1uN9Q8fXAlOnzHz+7Hazp38
	SobelQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f4b3v1bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:53:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3ea727700so83521385a.3
        for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 05:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769635; x=1751374435;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeRBeFnF4lcno5Yc+pip1PsV/E+s7JmR6bAmZl2QfIw=;
        b=DfQQXygOm3PaHTy25elU6bKS68qEAIikZmr/R5esMVsLarZNnRTMIcLoS5e42+LXIc
         ABOYyI7gdHzVvaxi2kESToTtZiO9eAE2I/2XWB4iVUF0I1ctZy3TVf/bxYIeBGAN/yhX
         6FO+/7wGV40KtW0kTkq7yi85ip2MVGdUTnqzHl1WPrIRIQSmZfBMy5C+eAKK17aVwrAJ
         MQdpCYUwCtrei0d9fHW0ZxNWbkRvizDbx+cWPGhj3z9RV9PX6jxyHtVj7kMkxqtsoN9A
         cR8MkVdegL2NVVotVM+hahbPwVI7tQPl2bPMCzjQXCVALTYXufzjhoDxWgWsziKNjAg6
         U39Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyU1PxYv/F/T8BDetEBjHu74rZVKXCbNgRTl07zR2FtBfJ6RoyIKcW73L846pD7FbrmiwX39/+0UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU8HZBxecbSZFwlEhVDCkVPVv1OIB9wgyqxXIHCoUVWWryx60o
	gGxxtrk/BU4ru2AUZGi6qn9afaRJi06YDqVD9Hw5gefs5O4FCty5R/EFKRDkOzM452rcU7sU241
	3T61P6qQCf3wDMqMFMZFE2OIuHKUa9LIkCo1r35YLkjBPiMMGiS/VvPDNOiqGxBw=
X-Gm-Gg: ASbGncvs5OPFzvw03zMYfKngaugMxq+p6KScb6FeUPI87PTNgHPYuI///PsBdDxT4rv
	awNXiwKcGbeRZ3T6yxQPBZYGXPLcHs5Y7jNWO63zDjTpxPAU2XpGlklcnuGpAW029MA86TehbWo
	Wu1HTTa06gvhY4MZvS23wZoACxHC2KmRsfjPEj6uV5H3Prj0kQZjmY6FA4v8zUn5JSMLMDyXvy3
	DjCmUKRhPg8s49gaxJHRQUn2eetMof0bcle6HLMfg7U67Q2L8wziKlmk7tkVs3goygK72hL/4Im
	1LcD4nrOgdoLBiwcn5waUi1oDtB/A+3dDZN7mWR8lkAwAU0waYRcgRPLCRE6a7pz/msGZrdIQkx
	cwYY=
X-Received: by 2002:a05:620a:26aa:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7d3f98e252fmr757962685a.6.1750769635202;
        Tue, 24 Jun 2025 05:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm26Atmzo8lMPkhFJw/P2Xp8LDJYbWX062GO4T8ZPwBCNOZSuvof419wfPyXwFJWWZBsaOMQ==
X-Received: by 2002:a05:620a:26aa:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7d3f98e252fmr757961685a.6.1750769634731;
        Tue, 24 Jun 2025 05:53:54 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4975a1sm1007741a12.68.2025.06.24.05.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:53:54 -0700 (PDT)
Message-ID: <9012d2f2-b9b0-4fca-a047-5b5adb921ccb@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 14:53:51 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] firmware: qcom: uefisecapp: add support for R/O
 UEFI vars
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
References: <20250624-more-qseecom-v3-0-95205cd88cc2@oss.qualcomm.com>
 <20250624-more-qseecom-v3-3-95205cd88cc2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250624-more-qseecom-v3-3-95205cd88cc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwOCBTYWx0ZWRfX0imkqEDbEjGg
 bh/AJOnnhTaNeFW+fxeP4eaUt0IIRTAHXc4WiKMz44wUOmWbUhFVqaFz7QzEHW37w4D2my07vq7
 eQ+yz+CyTO9X36yoFEp3pGQEqW35X1efBbDTf68Xiz1Q9AmjCrEDNe1Q7Ue30Ch/U8JYEvw8tK6
 0ObmhCxu2MHgOr1oXplUpMKx3Q1DY6IxE///u/gdLbpVJ8onw+j6dXYwBzBiiiz70ZgnvxRNJ98
 eDzqG/NO3czk/uPjeHO6KYL1jcPxbQouSScNCwUxEsCzZtv0BY4TfcL4uEDp0i1nmEPtS8riMFn
 4FR9srY6GBTtniFAZ12jejr1Pw9n8/bokhzW5KFO4h5lozJMy8XIBId1AAf1tYFn+Hv2aloj6h/
 glwkI8gVszpVvxFGq6PRYOoKK/46UeV+qmCPjarnBOWdV+jzkYbl/P3FwrlfQfjNYA7hxR6f
X-Proofpoint-ORIG-GUID: KfN60HxiMSud2JjleSETiwujd4JbKkOC
X-Proofpoint-GUID: KfN60HxiMSud2JjleSETiwujd4JbKkOC
X-Authority-Analysis: v=2.4 cv=A8BsP7WG c=1 sm=1 tr=0 ts=685a9fe4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=aztlNrSj1wai7b1BO2MA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=937 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240108

On 6/24/25 4:13 AM, Dmitry Baryshkov wrote:
> For some platforms (e.g. Lenovo Yoga C630) we don't yet know a way to
> update variables in the permanent storage. However being able to read
> the vars is still useful as it allows us to get e.g. RTC offset.
> 
> Add a quirk for QSEECOM specifying that UEFI variables for this platform
> should be registered in read-only mode.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

