Return-Path: <linux-efi+bounces-4350-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C22B0624D
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09EF165A05
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6D1EF38F;
	Tue, 15 Jul 2025 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MVqhKI0E"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1113AD1C
	for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591536; cv=none; b=nFZpEM+F4U1NzbF1pRvIgpk070czvwHkJKbUUXLhu9cIntb5SLBoOCbbA2msu+zAfVUB41eGMr/UAIUDS2NxLwmuPkPNfcW6R91BdkJfNr6xyyYsZA62zG4uEETgzNoNGnN/Ef4/b5OlDwrrkaTrwwl7AaR64aScxID1rvRCADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591536; c=relaxed/simple;
	bh=RJgtZNUEZzN9hGx+4AfBFEa2QJOzHnj3a+2Fa0Jy63A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEWErv/aqiBpqZ4PNBOwFv70zk/Hs3/lHr81gy08uxumX2cvkj96W+evi4xkz/vJw3zHU7sCBKI5yOexx6LzlW/LNceDUz7OT1MfrK1k7cfTmlqHEv/U4c/PBzUmorJyq3TudJ5we1kceDK3LpxHVnn1CH+VU9UvtxUunj4Icro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MVqhKI0E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747fba9f962so4581676b3a.0
        for <linux-efi@vger.kernel.org>; Tue, 15 Jul 2025 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752591534; x=1753196334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mvahs9K3Kwf003Xrbc0oMQlkzIbQnUN8rpvZVnAjj48=;
        b=MVqhKI0EqGwLxsJJYXSJjcwD8KeF1YRS2jGRphp2kEynDAJWzeak0xjSgEGiJNY4JZ
         cJDU/pkS3gG/M6DgW6RdTFCyiyL+r6bqtCvrcVPIehXCcmcchVVXtagCqfgMIoOThYLu
         s2YE1Dv9SqRPZFNNe06hd5CSukLAfAhHAwYmKb5GWxhwxXv1gOMyAXRCNzPFyWFd05pM
         Z4vVUjidVjg4GUXasE7swLMBsiS35dL8qhans6+BR7CNPeLpYgeCecGwhspywguJLoSp
         gEGY6VQPZLa0agZYgR18P8jp05ikffgy3baTglYt9X8p62CYJ5BM5AOuaIhMgFCymyku
         soow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752591534; x=1753196334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mvahs9K3Kwf003Xrbc0oMQlkzIbQnUN8rpvZVnAjj48=;
        b=JDiBYQ+AX1ua3mUaIE19DtsmyMQiDLJeOCWVCl4eWlQqpRVl78uMYkZc6hzmUet6s8
         n1FCyu+cNpQ+IBEe9Fm4R18g/psWpFFoSd+36nmuhESHkmPNUeGtg3AuC3X5X7GnPXW5
         fN0b1hVNrsNq2olpl2RsFj+zKUCRpghSbe0o77bvKJytVevWA9cyhvyzcJhVFDUlRhD9
         ERcNANfJx+hEq5aHBPOEUoMG6MXcrtTAbZ2jdoWFggJ4GcFP8+qLjpnkSlpX3lRMT29c
         ZgGKroUBR1qPTDCvyDJVt5Fkdc8oD/jU25pVibJ21M5mljwkECBsPjwbW3LhVa/WlNFS
         IeBA==
X-Forwarded-Encrypted: i=1; AJvYcCXIugRIRihU6ZvUUwfNsFhH4oyN3nhQAflYR5wUa2jjAgn8cdMqD8ijEDA2ZvoUWK36WRJRv+oGm88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4NpBzV3CPhNbwWS485NyQIVH5bPIMZMWun/ApdozxFR/JdK8
	ZQDZ/uZr0gKdSrIVuzgbC9XawA+JNU581GC3hTLVzTRkhi1zQlE4q7tVR+K9yDayLog=
X-Gm-Gg: ASbGncvfL+TST9Rwr9I8EvreUl+IAdNYWHtGRM4PK0xkNThS/iYZbkXi2fACxd0XGWx
	2toq5whqqKsm8/QgGrdTyb1GUPt0KE7+z34XIeb5kOxxZ+Ccajj4jkQxmlBen7pBH8F+pDfvdAH
	dJGemzJ4axFP5/h6Fp5b1ysQnAlBWfjBrBaIYnxKEqGSrEDOIiFYPmeBqzRHZqS5R8n/I/iioA9
	ipq2hMmEZwhMc96bHedrmRBNT6CfW14twejp8RjZwTKs85lhFcZEtVmrINff3sUgGwC2tl3GSoy
	xsMO4DMh6x7cnNruocgGTdOMBvyNlvVBH7WnY0D02stb8ZK+GbdSAZCr1i+rpWxMixcsRGLj5Vx
	51Kqlbdalie4B9sGCIzxrr8BAORU3Mg==
X-Google-Smtp-Source: AGHT+IGWqmTNcmPppTn41XmZxoBqwnqg0u0bN/W4bU7UhI4lYpV4O4cn1UsFVwKVvFBue7Ekoyiq4A==
X-Received: by 2002:a05:6a00:ad0:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-75584eb932emr5340905b3a.10.1752591533903;
        Tue, 15 Jul 2025 07:58:53 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b6fbsm12327709b3a.84.2025.07.15.07.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:58:53 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:28:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
	x86@kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Remove unused EFI runtime APIs
Message-ID: <aHZsohPoxLYML___@sunil-laptop>
References: <20250714060843.4029171-5-ardb+git@google.com>
 <422e2a72-972f-41f4-a0b3-d69a6cb0c2e2@canonical.com>
 <CAMj1kXEXpBF8hPaVMU0sDgNysYT66MDRmr3JHO4Lg1sJB_Yteg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEXpBF8hPaVMU0sDgNysYT66MDRmr3JHO4Lg1sJB_Yteg@mail.gmail.com>

On Tue, Jul 15, 2025 at 01:29:15PM +1000, Ard Biesheuvel wrote:
> On Mon, 14 Jul 2025 at 18:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 7/14/25 08:08, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Using EFI runtime services to program the RTC to wake up the system is
> > > supported in theory, but rarely works in practice. Fortunately, this
> > > functionality is rarely [if ever] used to begin with so we can just drop
> > > it. (Note that the EFI rtc driver is not used by x86, which programs the
> > > CMOS rtc directly)
> >
> > The main problem I see with firmware offering access to the RTC via UEFI
> > services is that two different drivers, the firmware one and the Linux
> > one might be trying to access the same busses or registers which might
> > lead to unexpected results.
> >
> > Recently there was a discussion in the RISC-V technical group for the
> > server platform specification where the same issue was discussed
> > concerning SetTime().
> >
> > As a UEFI firmware should not care which operating system is booted, it
> > should be up to the OS to disable EFI access to the RTC if it has native
> > access.
> >
> > Could we disable all the EFI services for the RTC in Linux dynamically
> > when an RTC driver is successfully probed?
> >
> 
> I don't think this would be the right way to do it.
> 
> It also depends on whether ACPI or DT is being used to describe the
> platform to the OS.
> 
> ACPI does not support describing the RTC device, so it should provide
> the EFI services.
> 
Hi Ard,
IIUC, TAD is defined for this purpose, right? 
https://uefi.org/specs/ACPI/6.6/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#time-and-alarm-device

> DT can describe the RTC device directly, so I think it is acceptable
> for such firmware to mark all RTC routines unsupported in the RT_PROP
> table, and just expose the RTC device directly.
> 
> The OS shouldn't have to reason about these things: it is up to the
> platform to describe itself unambiguously.

I agree. But I think even with ACPI, EFI GetTime/SetTime can return
unsupported if there is a TAD exposed with proper _GRT/_SRT and _GCP.

Thanks,
Sunil

