Return-Path: <linux-efi+bounces-4043-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120EAEC7EE
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jun 2025 16:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4CA17D5CC
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jun 2025 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC6251793;
	Sat, 28 Jun 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lJLHSA01"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BD253920
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122257; cv=none; b=IYHbFFdXLS0Nkzp14s0+aVnBAvAneDRqNpgMZZCPXSyVzVDIs5r86UHVPH58uLCwwJsasZfFzwGQThfkjrn6D2EY5NtUT2uT2HAndHbgPLLEL7qYaKhAEiXBLVK59ckiZYbvBAb+sq9AUbHm4+bk4xTQW1svjBRS9LutYFI6dbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122257; c=relaxed/simple;
	bh=Xos9O20zb2Et6svoO+8sqQIklPD/u4XqcxNOP5O6gGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/Psq8IYE3PDIEOyempvqb1LkLZ1JdJ+xGjqZzrfy6iY2KKyrMs61GtdRF7iN83zpbdSQc0ZXKEA+BDt0P1vRz9Yewazge54mAd0Gcox6B1hXb57rtaBAvXlU8ztyvLEg6JPUfg8ca18LFLIyaQcEEP29coLoB1Ct0E5/n0azT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lJLHSA01; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55SCTw8x020848
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 14:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4ZHuVoDQqcSiKZpcYlkHvG4d
	z+Aqe3P5LxxO2P06acI=; b=lJLHSA01cAR49QjeCee0z0kJL1m3UPZmQMsyveL6
	Nkgo/Mkmn8HAd3g2BZQazP/q4moY8TkltYKwgLRhGiSI/VdsxfPkfkSFGqyQqSy0
	57No2BbyVDFuqQCI4N7dIdJaGzd/BJql/2I4Dj3OqqPEMkbjOdKCNzmNNwrl7vlJ
	Ufjv5pTYV2Y1HrvNBdblobEkuWazQ0tXSUnQVuhjYIRZ/oztQrdI0zPOC+r6QOac
	WjpEgnFXOxArY+fbxyNqe8PKMxy0RoCfOJqdiBjlJYPKywGyDEI68b5Lm1FlUjed
	+T3PPQx1sG+A1nLCH2uYdCWy3Eae7I6lZrIBCCBG9ihvIw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fx8s9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 14:50:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a7bba869dbso18809181cf.1
        for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 07:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122254; x=1751727054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZHuVoDQqcSiKZpcYlkHvG4dz+Aqe3P5LxxO2P06acI=;
        b=sW4F9e1dThvu2OWLu9EJ9TvIW8+NUzTLHrEy3xHrHi3Yn0/dyhW1w7Ew1ueBnhOOEj
         Nl2d1YYNtt3OYg/rBRBNI7pfuM50+q9yG3vgtN2Yjj2pk6OKKg3YIpAc+2em2nDOoc6y
         PbJNV9DRo/EJ2yyO6e4CVj/cGD2bBLHC787+xEF74Vu1/0VLIwlDnI+Zmkd9TbI40hXf
         ulkeGrT5XCR86Si7m1F560XnMA+1BV8NIf6IA1TOVzimHUOu6r6/dwmCkR5iFd/F8xpm
         o8O4W0TPR8yGBsE6j13fJaIce58S14Liw2856FwgPmIJmuJEFE28yRV38SppfjI75Gy1
         6w8g==
X-Forwarded-Encrypted: i=1; AJvYcCW51KEXOXHoM6jAyvmKyFmjZKEmv4bB6qL0z8iI4suRitW2f2Oqk9yB05cT0Lr9urJT5d0bXNDX+6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0T2esBiIzsA4benaB2jwrlA4DTG69qhLWxLXTVRe1qCD0DQB
	6q8bc/+wTd13/9Xs23XEEjjdoGABG0N0cIq9naF7CJHEKJA6ttxT9Y9gm64nAcW9+9rEFECtxWc
	NOWnzzRQnlMcVC0Ktp1F9n6T5i8UTlyjRaB3SFAil0U5sOcEIEKCTHJyqc8UH65c=
X-Gm-Gg: ASbGnctTAd1RMlAsu/lvDhqTb4Fbc0Uq5N/GtK24oMJLKB0TgHEEASoBQlkazEuIgn2
	mZ/aExnyJylAGIWloJol1m3zJ5bCpW20LiPUIG+7VfXn1a0XLZxow5+40c8MDpxBwoKv4d79tZ5
	j50svpGw5IP8loA07YoeCiFqrAIlVazcfAUI2iso62xxCzIkvRTBpjIU17jaJ0egaR046c5LlCv
	SIPIzy+cHxCSlHCI7EKjBs1LJ/5h3HS0EPNKlp3zJZzHu/GIyVPqrwXUKne2x9QczQkYsUgNr1J
	ede5R2eru4R8jZDWnZtX+VN0cW2YkCe4V3RmL4NjrMeFVC4Ad5FvW97RHCzFZpQEdetMB9hiPUG
	+TJ3b7XhURokLt1eq8VCFtNW2vo/7nIY5uws=
X-Received: by 2002:a05:620a:1a10:b0:7d4:4c7b:9701 with SMTP id af79cd13be357-7d44c7b971amr476429085a.35.1751122253675;
        Sat, 28 Jun 2025 07:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVzNKJ3G+C5nuBNakv+tEHELya1wSjC0Lp4djr17ccnTEiCjJcAEFkK1IFL24QOiOW61XH2w==
X-Received: by 2002:a05:620a:1a10:b0:7d4:4c7b:9701 with SMTP id af79cd13be357-7d44c7b971amr476426085a.35.1751122253252;
        Sat, 28 Jun 2025 07:50:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2b93adsm828837e87.98.2025.06.28.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 07:50:52 -0700 (PDT)
Date: Sat, 28 Jun 2025 17:50:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP
 CRD
Message-ID: <hf66fa3pvm5jrw3qv57xoofmkoz74ds4g3nwzsdz7pip6e7nej@w3h7qn7qu457>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
 <e5e3e8f1-4328-4929-825a-3d8e836cf072@oss.qualcomm.com>
 <95c46d39-5b4a-46dd-aa73-1b3b9bf81019@oss.qualcomm.com>
 <aF6NUeNLPrR5vqEf@hovoldconsulting.com>
 <f55a057d-2cdd-411e-97b9-5ede1300a4e9@oss.qualcomm.com>
 <aF6Tkh75LRym8MQY@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF6Tkh75LRym8MQY@hovoldconsulting.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDEyNCBTYWx0ZWRfXyo59C1BqEAdc
 dlEt392sRI3hY2iBvGQpTTni0lwPHCtH/hOy8o/ofibJqGlpVQGvcwG19mV2E3Ox2pjVsdau/2t
 9wpzv0q/+b0PDL1OOegWpQana2w4awfiNDqrkTKHvmvNdmLbEUC4cQ8Iy7knwJ8GzgvcZfFTO+t
 hhHHKtXRFM9cn/L2ZPPkcDtJU6PyZKLuUsVkKchck1uwM/31AL8VAiP+PZM7N3Xy+Rs3kcg4sIS
 imgsEY4Raxn8fSVOFKxUQCtd73s949jLhnjoOyUtv8SGdQS2YBUAWXQQX/A0FG1phmXKUjMZkfb
 j85z+JLIT0WUFqtSp7Op64chX0CrBtsgcKfhnQ0Lsj6rlkslBzSsjRckyZp3gLZk9LRUysKUvWq
 AaMpHxdokXj5hPBZCYa7F7gIrCbjwJS92BRpJGhkcTJ66hBwLr9V9yaCKkxHfNThe/cJnEGz
X-Proofpoint-GUID: 3zfKicDnkmCYuzucKTlInHQC05fh4MBc
X-Proofpoint-ORIG-GUID: 3zfKicDnkmCYuzucKTlInHQC05fh4MBc
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6860014e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=38JWWdoTCtlzABMLL24A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506280124

On Fri, Jun 27, 2025 at 02:50:26PM +0200, Johan Hovold wrote:
> On Fri, Jun 27, 2025 at 02:26:41PM +0200, Konrad Dybcio wrote:
> > On 6/27/25 2:23 PM, Johan Hovold wrote:
> > > On Fri, Jun 27, 2025 at 01:54:37AM +0200, Konrad Dybcio wrote:
> > >> On 6/27/25 1:34 AM, Konrad Dybcio wrote:
> > >>> On 6/25/25 12:53 AM, Dmitry Baryshkov wrote:
> 
> > >>>> As reported by Johan, this platform also doesn't currently support
> > >>>> updating of the UEFI variables. In preparation to reworking match list
> > >>>> for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
> > >>>> variables.
> 
> > >>>> +	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
> > >>>
> > >>> R/W works for me (tm).. the META version may be (inconclusive) 2605
> > >>
> > >> Looked at the wrong SoC META table.. the build date is 05/25/2023
> > > 
> > > Could be that my machine was not provisioned properly. Do you boot from
> > > UFS or NVMe?
> > > 
> > > My fw is also older: 01/10/2022.
> > 
> > The machine has UFS, NVME and SPINOR, however the boot log definitely says:
> > 
> > S - Boot Interface: SPI
> 
> Mine says:
> 
> S - Boot Interface: UFS

Is this META even supported? I think it's recommended to update
firmware to the latest releases.

-- 
With best wishes
Dmitry

