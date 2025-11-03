Return-Path: <linux-efi+bounces-5341-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B992CC2C727
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996E44E6FB8
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566502DCC06;
	Mon,  3 Nov 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj8qVCEU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441B280338
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180864; cv=none; b=mHWOmFvq2WeUDYqMELzDgCcPB1zJxIwZEg1dk0KYISwIaIaWb5Y8Lg9MGW3Gowok8s0DI0euSnx//9E2jNnrZkOT/XtkPxSuQTQzjg0GUTOiknY8o5jPZpyzP6TRCCU1BEKaPBR9wFsWIHh3qtETWwu+N/pwXV9Odlj5yzL+H18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180864; c=relaxed/simple;
	bh=eWQeiP2zrgkz9osY0cSaodeycX0GFcYa/gGTxashC7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSHxTnvCeMJlMOEeubCCCgQR3a6EFJSTCBLHCaUpikp8llV37Zm2gA5G/jzy2ywOnUnRcNePbYw4qIrYUI28iGBS/AKnGEhLZQl7ZHT5h1w5HeCcUYwonSOnsCceKlNwkGIwWe28aerkDupuktFV/RVKS+zwa/DrErWyztgSY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj8qVCEU; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-429c2f6a580so2495837f8f.1
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 06:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762180860; x=1762785660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nhnWCeGj7VSUUXora3GrZpUnZAZG0ncmkOPbfdU7JnI=;
        b=Sj8qVCEUHq+xVD89nZZlQYDWpgbAnq60qhc9SiXS/hgQZD9jFCHMFEOltneCfqR/rD
         qfCQqSiIRSV2Iv3+tgLg5vE98Ek8rIYZL+wx/9SqwNuYKFyUG3KOCjotOOg77hF2Kx0x
         IW//bb0wOyxEGLQIlOT8Xp3IRjtKAMvjx6okpi0+cR2BX2rtl07aVEg7r+1OCTU13aVc
         jiIJrcRfY3/ZMKSd4YJZkew5U/lQNW2yFNP2FcTbZeyJV3bL01xSXoQtRjx25LkCukjQ
         ByOkz0Z4H+RyCpC9pxTyj0G/9lMz1d9tsj6elwuzKL6uzkL2yIIZHXzpsZkMhdpihBfn
         LrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762180860; x=1762785660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhnWCeGj7VSUUXora3GrZpUnZAZG0ncmkOPbfdU7JnI=;
        b=j7diF4e8dLK7Iw9qpDiL8wLJoD/ljYab7KYlfE0wWEC2K86OvkLIDjUKCP7GMe9Uuq
         EO/Pzy4U3IpwoCZz+rRKOEcBCiApbo+7uOYEzhGEkPFjqJNR8A6L7dxY0h/YAxAfwynM
         2EfLLyNSzgY5Yt16wN6CDNhXeH9OIFHj0jPBdXOfzwZrkSrrvZmYTqPreyMorPjS3U87
         DBVX56mzP7nROCde4uLCZJGWUpKsTrnm6F7jI+QTie6pOe5UTQU1s4q/UsR9/WY7FTMF
         eWeECW+pdVQTQ2okNWuvxo5180zLThuZy2SAKyQN0gTkVIOFyrl1j6sel4URhECFppd5
         Qv9Q==
X-Gm-Message-State: AOJu0Ywsl6Q0Eh2w8mkiLDeslmsBv/Z9oXsRhzkaLkW14a9GlU3jW7df
	NXadTBCBTCLuZdkyl55Q5UGLUs5K7CsEBdHUOEcv1F6MQUiYLGNOjcA/mo0ewsngH6vXZw==
X-Gm-Gg: ASbGncvKknogQQok3EhBPpShIEKTWBFoIfN4i67+IEf51a2r6Zpc4CbLWpTT+xfB6/x
	t1qEHdfN/oElxuqaC4kcZHp6ZMdCj2QNX3/ZK/u0ctjEdGbjyAHhqyhwASNcvkF1aHRuakhR+u3
	ELkUie8MGrZF7dYXJVq1x7IeY4RQWR8eebKEm1iNF5txl3Mk3EfP2JnmdzJr7O5PVBjSylmE6cD
	7q+aW4fvlDqMyx2Pe7X5koQkbhJ/icM2RKIVyoP5APu8YGc3g0l1ML4dnQY8yGPwRhEnP+Nl1nL
	7LJp3VjelKq2+5/XWyFHxGWvf4aOpYV0HEy/RRLrxO5ZWWNROs4UjqsVMUrA/bZWug38izJs9H0
	+i68VBZNO7rCV5khJ25qpURC6abCH39pcKGTrL/mxV6ZpJIsUx33ujSQd2DUnTtJeJx5dvcodjI
	22Y2WOJQ1yBJymkVndr5lrJ/PUNM+n3BnqEd4IElC73YugyCz6bWSf
X-Google-Smtp-Source: AGHT+IH/4xizOy+DuRDg4T/+1/r/B0yFQ05VGmFHc5NJhCGA96e19qMqEBWxN2MdSABc4RNojADaRw==
X-Received: by 2002:a05:6000:178d:b0:429:b6e2:1ecf with SMTP id ffacd0b85a97d-429bd682973mr11766202f8f.22.1762180859783;
        Mon, 03 Nov 2025 06:40:59 -0800 (PST)
Received: from workstation (ip7-114-231-195.pool-bba.aruba.it. [195.231.114.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48ee52sm162113385e9.2.2025.11.03.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:40:59 -0800 (PST)
Date: Mon, 3 Nov 2025 15:40:58 +0100
From: Francesco Pompo' <francescopompo2@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub/x86: Add fallback for SMBIOS record lookup
Message-ID: <pt44dx2hnzvqrqsboa53p67qw4dhkslo3xme4uu5r333ygei2m@czvvf5btllhq>
References: <20251103123335.1089483-1-francescopompo2@gmail.com>
 <CAMj1kXHO8Mxk+zPEwx2+VP1FF_LoDu58tbDOm+-Y8m07d3nitw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHO8Mxk+zPEwx2+VP1FF_LoDu58tbDOm+-Y8m07d3nitw@mail.gmail.com>

On Mon, Nov 03, 2025 at 02:47:22PM +0100, Ard Biesheuvel wrote:
> On Mon, 3 Nov 2025 at 13:33, Francesco Pompo <francescopompo2@gmail.com> wrote:
> >
> > Some Apple EFI firmwares do not provide the SMBIOS Protocol,
> > causing efi_get_smbios_record() to fail. This prevents retrieval of
> > system information such as product name, which is needed by
> > apple_set_os() to enable the integrated GPU on dual-graphics Intel
> > MacBooks.
> >
> > Add a fallback that directly parses the SMBIOS entry point table when
> > the protocol is unavailable.
> >
> > Signed-off-by: Francesco Pompo <francescopompo2@gmail.com>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c | 107 +++++++++++++++++++++++-
> >  1 file changed, 106 insertions(+), 1 deletion(-)
> >
> 
> OK, I've pushed this to the efi/next branch now. I did apply some
> cosmetic tweaks, though, so please double check that I did not break
> anything.

Seems fine to me. I compiled it and it's working correctly on my
hardware.

Thank you! :)

