Return-Path: <linux-efi+bounces-4013-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A1AE9DE1
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91944A50C0
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 12:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B713B2E1C51;
	Thu, 26 Jun 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZ9KGKBE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC21B4F0A
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942474; cv=none; b=b/Dc71OAQc7OJDERdB30KS3ixV5BDOHKeiWo0G6Aa+x7Qi8Fsp9S1qWVtraTpnD1zOFXQ2hNPA3/2khQee0HeOpWmU7iVMOxevqNwQANXRrtGDXDEEOKZwNAxPN2LZGhO9o5KJ6NSOTo1pUvUMzcl5jeZEvAD40pQ73qW1xQTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942474; c=relaxed/simple;
	bh=asdumluxlys5mpuCyqM+5LtmRLFjUYo4X/pjky7in7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCurHUuJf1CDjZkpVw2BBAvD7FjrGrzjK4+LCUgVyX6CJSBtyn77qFwgqlsLNsAF6m4OvaCkPQPM9Aaz8B4f7K0oG0bkeSACldOrEjxHnyTk37mKagvB4DAeDgPYWm+Z6ZYIzy6NTFLBFGAKO8C14IDkLnlBK1sfoeRp2IpsMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZ9KGKBE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9pg3T000431
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 12:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3x6shSd/yrF34vsnt1iiXfA6
	5GCU1AJJcNwTtSBnT2Q=; b=bZ9KGKBEnFFtGiR31CkiHufZWZC58eaxbW20N4DF
	B9YElwL7IPI63Q7O9LelBe1Uit11W+diCIaE2aMzdaMe2z77KxVdevvDbhty/aPd
	Ft84E0co7UN1TAD69k13W7MvWF+5ZMUfhEsX03rorFY32TaYGbu+nG3qnmkohMWm
	HrqdfJix/VIPHbl85zdJK6d+zSv6vrViOSYBOaKgFr1R6QgRjlF+eK/Beh8DouKc
	R6ShdJb802EcI3rFkdzB9wdWor7rfNi4jFK+HPDWtDrO+ZbH9PExQ7RQyoKgCshn
	rPBrBEvqDmfTf190r14j7Ldgu755rGfff3ppSsvXrSR15w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rq3jh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 12:54:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso996222a91.2
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 05:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942464; x=1751547264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x6shSd/yrF34vsnt1iiXfA65GCU1AJJcNwTtSBnT2Q=;
        b=xMfUGYlWP2gI591gYObdU7nVofT3f+ol7d0rbNgroLJjSUZW0XCBEoR1V2kkWAAAfV
         148fKZRG83h/DLP+ucFs/nOIWtfEz85tinMAIom3fHOquluhDyJiWrZfMDOEtGJSqSbu
         cBg68Rovhn6WK2oDciEyPNRssf4GfhKj/lqMIrNjZ+PLwWGqvZdaYtAj7AMCho+f2Vrz
         QiAn54mDtWjE/ZdTzLZzEbvpTYI+gv2SuldEOyC9PF8Xz9ueCHqZKY3To3oxBHitKa/k
         jB5ma8Onu1U7rrp7hLIhI6qdLXC+q8U2Lqq6Cs43y1eF8LJuGeFHgpnlAaPfBMiaNOol
         NvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiznJhnRh+2grv78xrZjGMZn4Wb8N+BTBYZtImSnt0Fh8Wh2zlIKnbIh0PbaIVwTBQ2D1vNhUz0RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPQPfJdv7+p6pH1qBX9MG2dM8kO0Ob5N+wh5lZqQOIqPlo00Q
	PeTXBPXImZZwYq3/6T/5CXnrgT7cHpopc+J1rz+4osfv6mHevWgyn9Cw/y1OmSLhjEwjMhQ8uJy
	Q1RzdJnFPH0HpB8ohO/WWEDnFGTuzvt4hYu2zJoogTddgIX5orWbqFmyOUq9qCMepEZRndDDwLV
	HyeOSY/uFP9Fc4HReO7BsLHGNvqC1p7HT+2W8wng==
X-Gm-Gg: ASbGncuIr8+OQymzjAC14AXdjhoE+DgQ9DxV4z4Vs7L5ORClygB2dMvaFw4M1u5v4Xs
	JPhoJzrMW1SnLCPvDDn3+I3zK+lfbpZ896/LLBWNOuwp5GOxNjrvla7g+vLE9AsmloIXd/YDrRQ
	OJv46HmcbbKbZeAoWvkw==
X-Received: by 2002:a17:90b:4c4e:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-31615961004mr5428795a91.24.1750942464339;
        Thu, 26 Jun 2025 05:54:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuAIj1aEqYNeOoxb9nP2pAN+XuVJjT0xlC2v4akSLt4zynbmjMB91F5msiUFqnswgOqwnZpMRyUbkvjb89yQU=
X-Received: by 2002:a17:90b:4c4e:b0:30e:5c7f:5d26 with SMTP id
 98e67ed59e1d1-31615961004mr5428759a91.24.1750942463905; Thu, 26 Jun 2025
 05:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
 <aF0bLtnABcGTi0wM@hovoldconsulting.com> <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>
 <aF1CX2uWZ_KaMDVR@hovoldconsulting.com>
In-Reply-To: <aF1CX2uWZ_KaMDVR@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 15:54:11 +0300
X-Gm-Features: Ac12FXxVTG1v8Nw68lgTtYQ3zkEFEeO_qii9xMXVu692vfF36NTvJZSjEsoMVSY
Message-ID: <CAO9ioeWwyxSgG9DNYpW-Z_SU_Scv+4sSBs8UeZnxFz+tOaESEQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] efi: efivars: don't crash in efivar_set_variable{,_locked}
 in r/o case
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685d4301 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=VwQbUJbxAAAA:8 a=9OOZl2ZXbS4rxasUFm0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEwOCBTYWx0ZWRfX4exZCReturQ6
 ckqFOSNLpsIG+3FTLIw1QEYEY86RvM0R/Mh3pF1NZaswiqtWe5UCMOB8bjmaymFVSWdW+HOrXr5
 tXCCDngHPfqsePqwHSHwuHntKswjPRlNsRxNRas7Bx8Jrd2aBOGiZM38DxnOfdbrCTEKhHIX14H
 wVfXYEfVXC5JxBIGbflfEDVEWPX/mLMBXKaKPxkv+a6z8PfmNVvles12apBipMDl06AgaBSBdqZ
 cP7aXSznF4IiDK5IpSB55nOvW4i9yCFCSe0YSnZuAIVulcpW9nQTQ6CyJsZY+1sbWprhjQRwAwI
 Cgrb3crcFQ5Z/jdVXTtgIf4LHkmjRhdkVu0OlmRY0ZN3S9UnzJ+PWnWs48rWpxAuA3W5FCxEKs+
 dzAu5+PNDIv/r0VUqzZrDNe1/XtDLzM/A02hp/8N+OXU+ZeNBThuJD9cgR20mIPNj6f/2Ym5
X-Proofpoint-ORIG-GUID: s1Ye67rOhQ3q2Ien-8ZmXn9qweOFeVLF
X-Proofpoint-GUID: s1Ye67rOhQ3q2Ien-8ZmXn9qweOFeVLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260108

On Thu, 26 Jun 2025 at 15:51, Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 26, 2025 at 02:03:44PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jun 26, 2025 at 12:04:30PM +0200, Johan Hovold wrote:
> > > On Wed, Jun 25, 2025 at 01:53:20AM +0300, Dmitry Baryshkov wrote:
> > > > If efivar implementation doesn't provide write support, then calling
> > > > efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> > > > RTC offset) will crash the system. Prevent that by checking that
> > > > set_variable callback is actually provided and fail with an
> > > > EFI_WRITE_PROTECTED if it is not.
> > > >
> > > > Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
> > >
> > > I don't think a fixes tag is warranted here as it currently appears to
> > > be expected that the callers check if setvar is supported before calling
> > > this helper (e.g. by calling efivar_supports_writes() as efivarfs does).
> >
> > It is not documented as such. So, I think, we'd better not crash the
> > callers.
>
> You need to look at the backstory to determine that before jumping to
> conclusions (e.g. start by looking at f88814cc2578 ("efi/efivars: Expose
> RT service availability via efivars abstraction")).

_documented_. I'll update documentation for efivar_set_variable() in
the next iteration and add a check to the RTC driver. However I still
think that this patch is valid.

>
> > > So should perhaps be fixed in the RTC driver if we agree that supporting
> > > read-only offsets is indeed something we want.
> > >
> > > Are there any other current user that may possibly benefit from
> > > something like this?
> >
> > efi-pstore comes to my mind.
>
> No, that driver is also disabled when efivar_supports_writes() returns
> false.

Good.


-- 
With best wishes
Dmitry

