Return-Path: <linux-efi+bounces-4045-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519ADAEC825
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jun 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A9117A8C7
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jun 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5823C2356B9;
	Sat, 28 Jun 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pryb2CJD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F52063E7
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123158; cv=none; b=DQ/IDapSIStYUfZ7AJLhWbpEeP6Py4UKdpjS7VFCimuf37NJTd9s2jhaSWE21/1vD8eFVK8IDjBZGTx8NingPZAJ+NU34M7Y7VBz+vIrT/yO1Q0PHinIkatlDI0jsC/JiMH8geNxkJC7xABEXaqVV3K7xtqAH/Y9KZRUPUpyd9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123158; c=relaxed/simple;
	bh=AFrWNMz8XFIVdHFp3l6CQGNtCKzmfophqPeOq/6AHIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAFjfKzJrMtI+B/rlWYy7bojtf1H93sEdQK86wkN+krMLlU+N/vr8jAgk1Xi25ssq7me/NTokHgK/28XGzhm/n9tP0uuq3gjG8v6T6WabhL91oj07VmCT2eXKmI3t8O5B8oumCyHJVatFuJhE1x7bC0uSOmM0nydXGio3RTUnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pryb2CJD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55SCoICU028814
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 15:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=REMq7jxI3For+dVSEa7we50s
	2EoA0DEE+aFxW/5IRiY=; b=pryb2CJDTK1TJzSAOAJR8fIFvMN8+qF15WMC6tt7
	ZSO9D6WzFUmsN9zMIxRfFSsn8Afa+TghBy38RWaJ3bwv+IAfhFZCMrEG7e3uFrjt
	qfNEQ+k+f4OKurLck//DJuxf2E8w0xl/hZPhSJqNjsldgnh3s2BBXv3SWpXZxsag
	mLdjWkkAP2ucSPIJyCuTmqWAbz/Hcb79NmtvfAgEsrF6gjwzNkF5J3Ix0/hjxFaT
	rEWZUal3OlobCwre33mK09dxqBrKGqEwpoMqJgXmVcjEGujk9Hpt2qDll3zkpXGp
	NQAJ8p8Xqiff6B7oyWeRTUHjsbhJqcx4GEB9efr5nrma4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j95hrr75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 15:05:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d446ce0548so137514685a.3
        for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 08:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751123154; x=1751727954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REMq7jxI3For+dVSEa7we50s2EoA0DEE+aFxW/5IRiY=;
        b=f7ZfltECIJNnHeYac/pCYepwiKI8F2tfP3j1MOQ/tc3wxp2Fc7fghUdQNmXYEyt0Vu
         BsPsp68tSGPUgOEfMftTBNrD9PDfqNhrzkyzeBR6RPvgx1Ctf0ayK3c9drpcJKFBzpE/
         U/7BS9wwX4u6HeadqoWU33tlC8Bc2CC3H6hqyOqpNaIzXglOBLyNy9X/fr/ZGlcPtoq2
         6yVdjMNB3SSnyLRrJmL/8HtfTaHXo99ltcMqEUiKECZh++lkSnrZhlVKu6z1z9duMDHR
         2BL3aafHITLWzT87bzCQmBheertE/OaE/fs0Ex7M9wbPgYJ+GuhI644VXo0g50RCz/so
         ELzw==
X-Forwarded-Encrypted: i=1; AJvYcCVLhmqEGP5Jujfej94MdNCgj3kScymLNDPU/sT6WxvR36fZZT9MaKxkC582zctCPArhipGO4q1emDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kNOTBHKNz2DEUU/pnYt6+1Gyqb8sF7mmsLWLyecH30vYSHFK
	GPOdXl5CvL++zRNhe6GI7Mry+ZbqJFt1pKPoQWsqeHz6vyETUKtfSaMWd1tX/6zKZ7n6tDEVJMX
	Zqn1IC0WuagYspM/LHnToInbjmrKBRNI6a0lpJP4Gl31EMxHfXoD0nWERlp/CaFUx2h6XjisuTV
	IK
X-Gm-Gg: ASbGncvflubMemKTvBh3l0w7eYBLKdecKDVPK5VVFpF+PJAoyLM5oCV2sAQBI8/ok7Y
	fp9+Teo0cCSIpY7iPNR/PxAuejGCfcHMr5eySbOnJJYBDobhr/IPkKzvAm3d3ze56Nez/i0QXZn
	hbXxUWjDlT99aBDN+S29tMYXqe8BIr5l48GaBimNvxhU6ZqXaDB96mD7HMzWXrDInymJacPx7+n
	F7CKYECnbJIkWop559t4z3X7lRYEKlItHlozfsJ9FXyXWqijOXJ1ht13c8A/ahPGMBobGlgFVyk
	mNo/dK3nPYFchLa2xhLxj7f1RjcKGVM0YifoCTIpITFDQ00MKfrAWlrF2/KInzcT2CC8BAcTldu
	WDptwds0sOhOOourQPgysBKxU3OAgT4CU2S4=
X-Received: by 2002:a05:620a:3195:b0:7d4:2853:9193 with SMTP id af79cd13be357-7d443934b02mr1106291185a.8.1751123154264;
        Sat, 28 Jun 2025 08:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm3pn8s3sBGrZoWRJj6KiXoAZdAGLqhC04uglE5dCO00aoW4M/1u+4v2iGvbuORAxhT3Rd4Q==
X-Received: by 2002:a05:620a:3195:b0:7d4:2853:9193 with SMTP id af79cd13be357-7d443934b02mr1106286585a.8.1751123153829;
        Sat, 28 Jun 2025 08:05:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2ec5e11sm8075381fa.67.2025.06.28.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 08:05:52 -0700 (PDT)
Date: Sat, 28 Jun 2025 18:05:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 1/8] efi: efivars: don't crash in
 efivar_set_variable{,_locked} in r/o case
Message-ID: <h6huo4dohj6y5ne6ehs7ysjnarhtlztyycuztaixpvumvskmjj@x64n7svubc3q>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
 <aF0bLtnABcGTi0wM@hovoldconsulting.com>
 <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>
 <aF1CX2uWZ_KaMDVR@hovoldconsulting.com>
 <CAO9ioeWwyxSgG9DNYpW-Z_SU_Scv+4sSBs8UeZnxFz+tOaESEQ@mail.gmail.com>
 <aF6OQqD9V7AYUkwO@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF6OQqD9V7AYUkwO@hovoldconsulting.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDEyNiBTYWx0ZWRfX6V+SC2nWHCy4
 8c7sy6+GEYwGqfWJYh9m2nzy70uDlarew3Z2+S6YHjSvi1fvPxxUYlx2iOdirE9j2uJ8FHFBPYr
 GdAWPA0GMSN6FVf0Ambi82ObAczt5LNG5RoJK7Q3Ory5gHmZToghULT/eykpDqucADEdde+3HS8
 x8f2N6xq11wzkmH3gMHjdcpEcvN+LhJ/vbjgkcVIygO5ypJ3QC84Am8n4G8ABBFPfdFUskxrY+Y
 qoyl+gyicIryIdBs2qqXSuG/AzJnZJcQCA2CQq62nz1BjNulj77F5WBKlO31TXcS6A66xiE0GkN
 0UnRqCpvjL9vI+7z4UtdCAFWLR50xmsrDbBbsC5oFZjt/inkvtYgTDX8dU2oMu+zROf+hCPzIGz
 BigNxxoc2crkHAowzaFsQtq6izu+BeBApXi/BruS8hgUV4OKO2OILfG80+IuNMf8BcXnVeWq
X-Proofpoint-ORIG-GUID: 6xi42u-xREawKbmj7KwPvAi8W9pxT2J7
X-Authority-Analysis: v=2.4 cv=EuHSrTcA c=1 sm=1 tr=0 ts=686004d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=dxwQtu9T7pfLJM4xsnMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 6xi42u-xREawKbmj7KwPvAi8W9pxT2J7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506280126

On Fri, Jun 27, 2025 at 02:27:46PM +0200, Johan Hovold wrote:
> On Thu, Jun 26, 2025 at 03:54:11PM +0300, Dmitry Baryshkov wrote:
> > On Thu, 26 Jun 2025 at 15:51, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, Jun 26, 2025 at 02:03:44PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jun 26, 2025 at 12:04:30PM +0200, Johan Hovold wrote:
> > > > > On Wed, Jun 25, 2025 at 01:53:20AM +0300, Dmitry Baryshkov wrote:
> > > > > > If efivar implementation doesn't provide write support, then calling
> > > > > > efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> > > > > > RTC offset) will crash the system. Prevent that by checking that
> > > > > > set_variable callback is actually provided and fail with an
> > > > > > EFI_WRITE_PROTECTED if it is not.
> > > > > >
> > > > > > Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
> > > > >
> > > > > I don't think a fixes tag is warranted here as it currently appears to
> > > > > be expected that the callers check if setvar is supported before calling
> > > > > this helper (e.g. by calling efivar_supports_writes() as efivarfs does).
> > > >
> > > > It is not documented as such. So, I think, we'd better not crash the
> > > > callers.
> > >
> > > You need to look at the backstory to determine that before jumping to
> > > conclusions (e.g. start by looking at f88814cc2578 ("efi/efivars: Expose
> > > RT service availability via efivars abstraction")).
> > 
> > _documented_. I'll update documentation for efivar_set_variable() in
> > the next iteration and add a check to the RTC driver. However I still
> > think that this patch is valid.
> 
> Still depends on *how* we want to address this.

I'd prefer to address it in both places.

> > > > > So should perhaps be fixed in the RTC driver if we agree that supporting
> > > > > read-only offsets is indeed something we want.
> > > > >
> > > > > Are there any other current user that may possibly benefit from
> > > > > something like this?
> > > >
> > > > efi-pstore comes to my mind.
> > >
> > > No, that driver is also disabled when efivar_supports_writes() returns
> > > false.
> > 
> > Good.
> 
> Ok, so then there are no current drivers that will benefit from your
> change, but you may (or may not) need it if you enable RO efivars on
> this particular platform. That is, this patch is not actually fixing
> anything that is broken currently.

I'd leave that to a discretion of EFI / EFI vars maintainers. RTC driver
definitely is broken in its current state.

-- 
With best wishes
Dmitry

