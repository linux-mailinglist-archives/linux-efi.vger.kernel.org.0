Return-Path: <linux-efi+bounces-4005-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0377AE9C1F
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 13:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575453BE337
	for <lists+linux-efi@lfdr.de>; Thu, 26 Jun 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48142750F3;
	Thu, 26 Jun 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eEHn/wCD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4BA1DE2DC
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935831; cv=none; b=sf9LHKRTn0ZjYeY0CkCfyhbINGTW9gUm3TPKHmoMAndIGhE9Kp5sjilbU3nhdat32u3Ll67WNmKG+iSGdiRsUwOvqVsero/A6G7R/1AO53ozKZW31aHfSKcNwbGCkMJEpbRhJPuRbGaZJ0nFU9FkKS9k3+Ri9OMrtByTI1AWnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935831; c=relaxed/simple;
	bh=tuGT8XW8rHBbFXu3KFzBBDY3T/l6VMT1FnYa6Mpkjoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTcXujMgPGB3LwmQ748VjJJ4tsFHKLQy/zeppZXIB39WZ5a8DZjq+NksI73uqAL5wU8NWpj0LEGhi2OnN2HYjoZXaYKVIqE+8108k1fRsjLpB4G1bmSqHvTDbOQpJ1wK29/KldiWduy+c1bQjaJi2WvM+4ia5aQ4z8UIvaQqie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eEHn/wCD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9xR6Z009789
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EZwk1pKkeLiyo8jw2Ozdj+04
	ebjECh2JuYWqOTipUaE=; b=eEHn/wCDOprb+hLZaCBpTjpQ4Lc39cdJ3SrQ7tu+
	bvk3xc0MtqKLpTaJUxpqGnpOL+UgWrJ/2O+3aS7t/ZOLTGIu6t1qHhm/O9aT7Yl4
	8T551wjDWq353tIAKkplzcnAq4+AzKsQO4xe48auVRpcsazwxBmxcOoUtGhpG0CN
	+w4i94ZKRjAKkDoKODqcIc7JbyzTCcxLdRXWw8nnQjOkGwBMj7LapQ4EwIZFS1BU
	VQRK+jMnJXQbxOpiOaO31tsCL7ZAWubGUBAAfsnKhI0E9/2SJbw5Ae22s19tkXqF
	WNh+0tFDe02zUt0D6XaVOHMxB0N7wH9QjDlz8+b8aQTUyw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqsgek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 11:03:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3f0958112so128835285a.0
        for <linux-efi@vger.kernel.org>; Thu, 26 Jun 2025 04:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750935827; x=1751540627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZwk1pKkeLiyo8jw2Ozdj+04ebjECh2JuYWqOTipUaE=;
        b=B29PY/8i8ZDpswVYAiqCyFlL4AaTSHT9HwOLZTpGavlnpO0IJ6ATh6zFqPzoyBHChX
         cz53U2G5Czp8+ZanYIvP6Px/Uyfzvzqz5X4p4EtQxDOeSAm7eri1Ett7Ftwqm1SC5EVs
         YUM+8MY7IDRRNAsQtLL5Zgw/zAFbMnw2SC2YyZYQnnJgsInirHhEuXQnw54VmwbLdqKt
         oYkRtXv5XtjwqUDCNbb0ETrf67uX3HQbEhRkWnOLL44J4ex0NqwLJEc5ikISsLFYaRTz
         UvghJM/W7A/MiwRcU2VanvZkVSGedhDK2fLQHvZa4kkjiiddTIcDD5ntXbSz9UyJPAhC
         cCZg==
X-Forwarded-Encrypted: i=1; AJvYcCWusxkOMf2/4KfsmdAOmHvs3BY0EO6MnsY4aAihW2/uDjdNkhyV4rLcsowH+LeQKtmwrjosWXwUEWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDj0zQrNbARH3clkaztaozXloG0xC/4j8TMaiRI5xMuyY392P
	WPUu06+FhPRFA1zOf41RRCS6Tgn+9TvjRns5wVa4f6T/bHujUuRjuWD+U5zGw+aiwJy/oYTH+jq
	3YdkaXy4ALcOOEtHRFBm/FtBneDKoXL2YlFxmdFLYEsltZJpZNk0Wx3H6AfTvEYw=
X-Gm-Gg: ASbGncvWKzsquZHI8OwpO404V8r1DWAiS6lBdKnxln7e/0g8jgQXpmdpeh5KuH8J+1u
	YnWbiMJVVW7UFquBaC8PLkRiR68ZsVHPsUD/uqwSTCiO9jL1uqu57PheB82nnAgIZ2Gc0OFRs8I
	nHJcTYcQ0G//PBltbqcCYvVt30cJHTRlGPkZypQzELV1XJyAtLBZP8p2FfGxsh+eEqka4bSUWtR
	AZ0GozSnvUgOzQj1DBINt0Er6aih0DWYjUcei5RJhS8/5XULqNOdQC0F5dhq8oAyxVLflsDrkFN
	Dmfl9ZTvx2cd4W/wVf8S7k5VDbDHVs9ty3MsjK2Mux6fuFGfvBjPx76APcPj2wQ3ddKGBgT4M58
	q2vSFfBfHuywBX8MBe4toV9678eI5TrMNFXQ=
X-Received: by 2002:a05:620a:568f:b0:7d3:c688:a58c with SMTP id af79cd13be357-7d43ba6f184mr401136585a.6.1750935827241;
        Thu, 26 Jun 2025 04:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj8zoi5S1oYETlxpiEWZ4hcHqwoUim29NF3B+sYbbnhwtnWGNdD7ekpAbc188TtZRy8dUh3g==
X-Received: by 2002:a05:620a:568f:b0:7d3:c688:a58c with SMTP id af79cd13be357-7d43ba6f184mr401133185a.6.1750935826725;
        Thu, 26 Jun 2025 04:03:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2e0c153sm1967091fa.29.2025.06.26.04.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 04:03:45 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:03:44 +0300
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
Message-ID: <zw5u5c2itmpxq34d22y5wmtr32d4zsmjj5clf77ryeqs5jgd4v@t3wjfyj43yra>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-1-aacca9306cee@oss.qualcomm.com>
 <aF0bLtnABcGTi0wM@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0bLtnABcGTi0wM@hovoldconsulting.com>
X-Proofpoint-ORIG-GUID: Ef-xkuE0eLAqWKrrcmnWyLSb3U0xK7g3
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685d2914 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=zitRP-D0AAAA:8 a=EUspDBNiAAAA:8
 a=CWZieSLx0XMgBVwFOAsA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=xwnAI6pc5liRhupp6brZ:22
X-Proofpoint-GUID: Ef-xkuE0eLAqWKrrcmnWyLSb3U0xK7g3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5MiBTYWx0ZWRfX3o2vRS9LdA+9
 kYdpTWXIOJT9ZtoHtCpTN9YEbT9z1EbZl55+6wS9b0ocJUmpQzn58aVYHpvgAwE73yCyCEoQHUI
 lRubIoIOIkIWcI94tUZLNPcRjxj3oT+dXm1TXPdFrwsi3JBqVZgpsKDiKeCRkTm3S5m9tDqplqo
 bhJFu9finvjvhAIHuJjuKUhExNCwAISD9ACZR7bxTD78d3RnBsaJoAsKkevz4GBPAnmjDG5FRkl
 fvKM6bgn10B1CMY6MHUjeiEd8+wnohFHhgko1ZEJGKHcxDisPFItzWqK4LQuy+FpbpvEk22JkpK
 REP/cP9OGAg7LUmJNcNA8GSzsou+FO8KWHYA5Nkr+L2eYYTllS06QLejXxuTjMaLMT0AlqqwFFp
 M6SZe+KE9UVr4hth1TaKSD+WwbIieNihmUTnJ83HwpNWWgHxgMhS4RMGAprkrhk4G5wgHw+/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260092

On Thu, Jun 26, 2025 at 12:04:30PM +0200, Johan Hovold wrote:
> On Wed, Jun 25, 2025 at 01:53:20AM +0300, Dmitry Baryshkov wrote:
> > If efivar implementation doesn't provide write support, then calling
> > efivar_set_variable() (e.g. when PM8xxx RTC driver tries to update the
> > RTC offset) will crash the system. Prevent that by checking that
> > set_variable callback is actually provided and fail with an
> > EFI_WRITE_PROTECTED if it is not.
> > 
> > Fixes: 472831d4c4b2 ("efi: vars: Add thin wrapper around EFI get/set variable interface")
> 
> I don't think a fixes tag is warranted here as it currently appears to
> be expected that the callers check if setvar is supported before calling
> this helper (e.g. by calling efivar_supports_writes() as efivarfs does).

It is not documented as such. So, I think, we'd better not crash the
callers.

> So should perhaps be fixed in the RTC driver if we agree that supporting
> read-only offsets is indeed something we want.
> 
> Are there any other current user that may possibly benefit from
> something like this?

efi-pstore comes to my mind.

> 
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Closes: https://lore.kernel.org/r/aFlps9iUcD42vN4w@hovoldconsulting.com
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/firmware/efi/vars.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> > index 3700e98697676d8e6f04f061f447391503f9abba..11c5f785c09364f61642d82416822cb2e1a027fd 100644
> > --- a/drivers/firmware/efi/vars.c
> > +++ b/drivers/firmware/efi/vars.c
> > @@ -227,6 +227,8 @@ efi_status_t efivar_set_variable_locked(efi_char16_t *name, efi_guid_t *vendor,
> >  	setvar = __efivars->ops->set_variable_nonblocking;
> >  	if (!setvar || !nonblocking)
> >  		 setvar = __efivars->ops->set_variable;
> > +	if (!setvar)
> > +		return EFI_WRITE_PROTECTED;
> >  
> >  	return setvar(name, vendor, attr, data_size, data);
> >  }
> 
> Johan

-- 
With best wishes
Dmitry

