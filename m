Return-Path: <linux-efi+bounces-5291-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C17C24ACD
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 12:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861D11A64EBD
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E217342169;
	Fri, 31 Oct 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwCqqe5T"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3933B95C
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908644; cv=none; b=QRISbJ23gehZw6dzJSnN6YY0LW2xv3+q1izfnPgq8IXWNy2K/Mpotw/3dWuIcVb0sUejo/EyXGRJgAens0Vv/1HwML4TGr4YaYR0DdoGOpC0/YLaNhtoeCsC45k+RD4cm9GNO4wjKBwu1pN5z7paFAl+o8IhTZ2dFyQ3aV8Tp2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908644; c=relaxed/simple;
	bh=8wAZl0Bv+8eSyqQfgeD+tzNAO7UMQVNbXvZn7LP+L5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYZ8gx7+fAZg1mnhFhhIny9q1Gz+T409LBXVywX4t+f+V2eayR9qxRl8e28b4JxpOTsepeOG42Ltx5aL3HzSg6KW8uglpZAgQ7Ryz5d9LeyRllDbm0HIlGpe/S6NwL0nAI8THiCYDtBpKvpTJhQWSWFcdwHsOcs6RuplMZVET60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SwCqqe5T; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7847ee5f59dso30906257b3.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761908642; x=1762513442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GMx94PXpl9Bd44bRwjfAPN60GnZnLha+f/UpxbB45Q8=;
        b=SwCqqe5TmM/wzsTsIA5BCqI+3DA1Rar7stYkaEKZe7ZPnWYQrwCHhQpAJTkL028c+4
         p2wlykKCedWcpk05FPF4R7I+oiU9wMe7y82k/DEFkzRNcZHJwlKBEQP3jXfUVWIm4st3
         qQfPlh0cW4DIRiKrCl6NpOOJdBGjFugBAbsXId/YHHdCab58+tDzUrpLx5z1HVnpJmfX
         nOwbeWtU5FL4aq3ZB8rfIH83hauXsl7wJ473Dg4iRd2rhoypWpLAf2C3/6ggY+kIxYho
         8RD0mDJkTrHrpI5OJ/zTCRGI53bd2IPj7dqTYAprdurJoNuHYGklpdS6+PA+rrSA7YvL
         K5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908642; x=1762513442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMx94PXpl9Bd44bRwjfAPN60GnZnLha+f/UpxbB45Q8=;
        b=h2JDtmgOciu7aiMHIo1u1Er8dsWci3LJLlmEZEo920zqoONL1Ta8z5D7b0HBba/iBS
         BFuxOKI2P4i3pOugHytlsRqQ5pYv2OsuTwRLTe1BMPJgn8bi8abUCxEWEnZF4h/Ae5lF
         MJMtYUxAbLTHox5fV7HsAXEhv5nNiVATWtyxmtPjXcrh9Jad4x8Xp9KrTYND4lHePTjR
         yEy0WnUWeKaO+1Y17H+uOqD9/CyXIVTHzfz7sBkOabmRYaEIJkupSfeD28iUfuXe2aUb
         +fWRsyJlP0YdFXTeP8fdmBw1bCFO/oT2xRqYoAVxBj8T434x6O8t/O9e9RCMxapRkhau
         /bBg==
X-Forwarded-Encrypted: i=1; AJvYcCXp6CwYmUrvdOhighIl+98IYWAa/w511mu8GQkegnb9ccYXUIieIM7o+Wy708lCERt3/jD9rrkH21E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIvyxpz9pkkvZ0/gDEWQFILgLp0bCHNxjsNWOiyU5sU9iSDfP
	RmeiJa26o5EHimcUm31YspjX6c2t1zkpa98jT9mwmcDIzQR+3PymxVuh8K7cVNjyQWUhGCRNjdY
	oL+g1d+Z1kK9J6P0PgKMDVVLlWwj5yNZZgBr2EDXNcw==
X-Gm-Gg: ASbGnctzGyWf7yeE+y820zZ/By1VqycBDgogibyjLczRH6McmMA/PuBp2blCDMUqay0
	l/V4uUag/9GSjQFR69PzmEsA1Opu8G95FXuGbq3yyMqjZZOHzTZItGKnoEBPOituVhvWqcpdDxV
	iOTWxtVyoQuZ2B803/VifuwAaeIzJSRiYDJKkrVrDK8Ulyw1GGXlWJzsyCNAyMWv35rsZSggmdU
	j5iQ8zX8iHrMIq8p515H8T+W7myMDjgBCKs2ltSEdkrYrcWZajGawTnTiW7WSAijFZ+wUF+9XGr
	GMmGhBTDYvYxDqX5ns0R4+nMClyd23w4YTs7wDEd
X-Google-Smtp-Source: AGHT+IENjMS/Fga4h9EGVaoBL/JjQIFhSSBeM0v44Hn+OuW65Q/a+xvvD2ieXhLRYKQlrWWpSRadCKaQfY/EdENAIpU=
X-Received: by 2002:a05:690c:46c3:b0:785:c4a5:8f5c with SMTP id
 00721157ae682-7864851b3c1mr26633967b3.38.1761908641696; Fri, 31 Oct 2025
 04:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031084101.701159-1-adriana@arista.com> <20251031101009.704759-1-adriana@arista.com>
 <CAMj1kXGUyzPQu14SOBs8GSsJ3+ASssNR1vCN5T8OzeEbXdBbBQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGUyzPQu14SOBs8GSsJ3+ASssNR1vCN5T8OzeEbXdBbBQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 Oct 2025 13:03:25 +0200
X-Gm-Features: AWmQ_bknhkycM9Zb7uWN1yqYnJarIE7ayygRrMnHr8ptW7rbfAvU0YMcrItxqQ0
Message-ID: <CAC_iWjKcoKk-=2ojNfatNbuZ5B5LTFLhURHMJg4pPOGD_T8h5A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] DMI: Scan for DMI table from DTS info
To: Ard Biesheuvel <ardb@kernel.org>
Cc: adriana <adriana@arista.com>, trini@konsulko.com, robh@kernel.org, 
	krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 12:17, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 31 Oct 2025 at 11:10, adriana <adriana@arista.com> wrote:
> >
> > Some bootloaders like U-boot, particularly for the ARM architecture,
> > provide SMBIOS/DMI tables at a specific memory address. However, these
> > systems often do not boot using a full UEFI environment, which means the
> > kernel's standard EFI DMI scanner cannot find these tables.
> >
> > This series adds support for the kernel to find these tables by
> > reading the associated property from the Device Tree /chosen node. The
> > bootloader can specify the physical addresses using the property
> > "linux,smbios3-entrypoint".
> >
> > The first patch introduces the device tree binding documentation for this
> > new ABI, and the second patch implements the driver logic in dmi_scan.c.
> >
> > Changes in v4:
> >   - Renamed linux,smbios3-table.yaml file, removed mention of ARM/ARM64
> >     (Patch 1/2).
> >   - Drop the second definition of dmi_scan_from_dt() and fold checking
> >     for CONFIG_OF (Patch 2/2).
> >   - Drop unnecessary goto on the success case (Patch 2/2).
> >   - Replace magic number for entrypoint size with SMBIOS3_ENTRY_POINT_SIZE
> >     definition (Patch 2/2).
> >
> > Changes in v3:
> >   - Removed linux,smbios-table property, only keep the SMBIOSv3 property
> >     (Patch 1/2).
> >   - Search DT for linux,smbios3-table only, removed the code searching
> >     for the previous property (Patch 2/2).
> >
> > Changes in v2:
> >   - Add missing Device Tree binding documentation (Patch 1/2).
> >   - Split the original patch into a 2-part series (binding + driver).
> >   - (No functional changes to the driver code in patch 2/2).
> >
> > adriana (2):
> >   dt-bindings: firmware: Add binding for SMBIOS /chosen properties
> >   drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT
> >
>
> For the series,
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
> I can take the second patch, but bindings need to go in separately IIRC.
>
> Rob?

Feel free to add
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Cheers
/Ilias
>
>
> >  .../firmware/linux,smbios3-entrypoint.yaml    | 25 +++++++++
> >  drivers/firmware/dmi_scan.c                   | 54 +++++++++++++++++++
> >  2 files changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios3-entrypoint.yaml
> >
> > --
> > 2.51.0
> >

