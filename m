Return-Path: <linux-efi+bounces-3952-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A78AE659B
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 14:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E397C192619F
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE1293C6C;
	Tue, 24 Jun 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lJIz/amU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B768298CD0
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769619; cv=none; b=s0sNDAdL+INkRm6ssGnsAaI4hokTte6+8YMfSGA+C/lrOepkc/5TnndDrC98+Y6MYiakHBVsFSKB52WXiK4UGNHbxWQrYuHwKNHOsXsAIUB2WOe2dylTVQv3SYGNLpo+OIEx753HzuvqGfX3jclm/WImVCTBUXf9tnDMv7TFW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769619; c=relaxed/simple;
	bh=goi+JYdc8hX2nZ6r6/E6w6bG2TAS+Qvi9wp+yVs7mTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mB/Lf798nW4lTipMXCUdBgD/tKry2BoTlr2nD2XJipfbSCFip3yTj4LZUAtUMPEmGFYjv1V6Ei0YnSUT+ukp81bhfHU22vriuTmay57918Xk+QHOMtx00uJIuHd+TUPEKh9Ujzr99w1ZNUGHCaNa2CyW54ewVUG3rELCmTnfiyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lJIz/amU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O8e25L014571
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/+Oz0dkYo1zBsxJyrMPTZE3tsWtgvUVNjRDnaW0KIE=; b=lJIz/amUFjS0TrRZ
	u3wiXr/pgY3UIxwtl7dqdkpeJJXL7mhZDFER4ufNRcQJBBsTZX0VXPOw13oxpK+D
	nxv0D0mz9QRPK0i7yAiQyJQY6vqgahLn7VyMRqkXcLOxfg9bh72aTkO1Z5QTSfhY
	eoaR1djt54VUPH2DruITojk5OhBOzlM+bckYLZQedGeDjOMzwQfcoFsZmauXin6D
	jFikalM7TdlD0Wyj8SeuV/YAaxCyK5FeUd+BwgCR5Ej1WRtxmokhvmA+Q/Lgn+hI
	FuS8CRscW+FOJutcWi8d2E8YtDMf987zzwf90oMAVBh+0vHrKArlCUCDhSt3+cNO
	saTQPw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpvbdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 12:53:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a6f59d5ac6so12441551cf.0
        for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 05:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769615; x=1751374415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/+Oz0dkYo1zBsxJyrMPTZE3tsWtgvUVNjRDnaW0KIE=;
        b=WhNLhK98DaiozEYEwhHGZD8c9id0Q3QIyUeqr0FcmNj4CVobaQN2DIgE+YQDH80Tnl
         j2+rdJUnsYGWLHo+HRObpQq6rgy52CP604NoCnVbgu0F1LE3sI2TgtNb8Ho8oSapcr1z
         h9tN+mVJ7EtX8VkJ335tVg1DXbaUwhFrXZq3aL6vI1RS0NV3qmlLtLTb41LEGHk5VU7x
         RhZQGPE51KoFh8KsZY0Owgj9Yg78x/ddAquRXuZejz89sCeSar3B8zh08n8OF9MkVEH8
         ZRuvDtRMAQv73QhAVD5KbzDXvmLeeiw09TQvjZTKVTmX/S375kP45azPIW4HQZ11RDqH
         gjvg==
X-Forwarded-Encrypted: i=1; AJvYcCU7gYrNNdZUbIdngoJq6MbtLQTKf2xKnCtDZAVe3SbtK1gqfW54HbnbUehyc2Z6nNzfN41+V3QKO7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsmhAqZ83aQSRmIZYIl2nfOMmCLCTmhf/E7VP+2FACiCmV7sx
	gMwYSZqh3NahyiSSkGP25MTLWI251Ez27CtkiQtYlwTSIi5jBhmCil/MMUhAM15Eq4rR/o73St1
	VFPfHSA94dz46eTOY1uWkBv5TEen91E/tKMCIvTrR2Op8mcV28T0TGFFOW++hclg=
X-Gm-Gg: ASbGncsOm8sWZbsPWMpLiWdRFdHHJ+i0J/JcozdpYCvastY4VX4igA4ZaK61rsuqzfb
	LEHq8gPtwefFIEIx5WLOwK27/GzFNzFch3n2babnSBwqQ3z2r43paeItmIVgsCBl9Y+M2+rzl+8
	1N1RQfnjDEAshaeIgHgcaWNY1sEuqxzgt1wJ4m7A5pBAEoPvndcDXCxgTiT2E+1Q8tyL996dfM6
	bnqomWTZxEmvlcX/NRFfVGqrkZW1Gh0H4ZpDue3miTAc7uoQWEbq/LIZiRhxn1yRZ4j8ZbmvncK
	0Srj84ghowL5EYZeDFEbwK7Ye6XUleKURu5n8AAo7mL2lpIbvYnBC2BCe+AfWh4L2jNStVzMAJ6
	jEys=
X-Received: by 2002:a05:622a:6182:b0:4a6:fbd6:a191 with SMTP id d75a77b69052e-4a77a1ae861mr87818201cf.1.1750769615257;
        Tue, 24 Jun 2025 05:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgsD3QcWc6S0AZNrpNBd+uIEeZjeiiG6NGMmKXQHsPOX3VXCP45konCfmawthc2DRqsam1pw==
X-Received: by 2002:a05:622a:6182:b0:4a6:fbd6:a191 with SMTP id d75a77b69052e-4a77a1ae861mr87817891cf.1.1750769614739;
        Tue, 24 Jun 2025 05:53:34 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a67a80a5sm151041266b.26.2025.06.24.05.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:53:34 -0700 (PDT)
Message-ID: <a9c012e4-40ab-49f4-a0b0-b4ebc4272153@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 14:53:31 +0200
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] firmware: qcom: scm: allow specifying quirks for
 QSEECOM implementations
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
 <20250624-more-qseecom-v3-2-95205cd88cc2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250624-more-qseecom-v3-2-95205cd88cc2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685a9fd0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=Xl6Gf3kKTQkptmOWZCMA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwOCBTYWx0ZWRfX9K9wZeAdGdBy
 s08RM7L4/u7SIkKWo9e6X4HyifSn8BosXhg/o0aaZWuJiW0/N4RNgwZaiFklc17ZQRK1Fm3qiXF
 bP28AsXPTXnK8dINLO23AkOE5lGPkNlmtZRRXdxCwMv/5zOH31Gus3mX8PTMDZbfHffqWR30W2O
 RRcAn24H08FvOBnG764CTXsNuEDj/aDdxbH5wOs9rxWjUtn5/lURWRrTRNjvVdO/D+m0CHaRyl6
 lG3+isVPd9Z/otgB6Og3ikK9IMtS+d6LIdCDFcjqLLB7k4F86p7L3SdxoVlZ6k0KSFDTU5I2jJg
 jrK/NycJeT5RKhdYotVzAK0lJXcZG8fCq5CI4SJrOsUxCc4wOr1fn6jqONke1lXreLU6QOES9OY
 sCyoyzT2RBBfLhJyNeXvCxtubH9dYdnsi1jVEj585Eu0Gm/2uLh0AR67nZgobm9+bdnukjIP
X-Proofpoint-ORIG-GUID: 292ypFzjd3gtqdJGeKj9QyQ3Rn--pIQW
X-Proofpoint-GUID: 292ypFzjd3gtqdJGeKj9QyQ3Rn--pIQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=755 adultscore=0
 clxscore=1011 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240108

On 6/24/25 4:13 AM, Dmitry Baryshkov wrote:
> Some of QSEECOM implementations might need additional quirks (e.g. some
> of the platforms don't (yet) support read-write UEFI variables access).
> Pass the quirks to the QSEECOM driver and down to individual app
> drivers.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

