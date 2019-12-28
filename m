Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF89412BCF0
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 08:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfL1HDO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 02:03:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45084 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1HDO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 02:03:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so12570543pls.12
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 23:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=7LQrseBnbzz2fLEJ7lDxPUbpPPvzsIUjZtO5UMbNANY=;
        b=pGe83XYJShZmFe3CP6jx34tiyWFBj+j5AwGYr2U1+pfTAPbU9n6BBR/+YrxN/gPNra
         10QyMSxtTf6q9MTtnI1PxAMliNaz2n6jv0mk/fjXF3SzSwpcwY8hG1e/hpOcF5T5whal
         u8SU91KptCwv55BcGCHIEA8GyKM0MCMHtiYjJqQbYjAXfWJBXVwa7gjfo3L2NYf2pRS/
         hRRdrNuuxp2hdqY0B/rRdkRCT4jBcnxcAhNphOhOK620oJ34RMmq1Lu0a2ffC4hfVBjD
         SNvskaawtUfW3QoiP2pIhV7/0ipr9pg0Sc/DwfD4P8nyn2NiyIqNY94MWJlI4dOs2iAP
         +rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=7LQrseBnbzz2fLEJ7lDxPUbpPPvzsIUjZtO5UMbNANY=;
        b=iu3RWJ8uIqP+JCf1xSJqxysPwzneVsnRsA/brEIZi6lbwW3+E9PaJFQECKuWMOYJeW
         hT1FUptzrNrXVDklvhfQLzNiPdv3uP2DUyfguAryTRliv1S+VOJaSSpEi2baOebYqC3+
         XuFWaGw6jY4Q7MTmnvNdPwmY+fGkWzRLHYnY3kPcxwv+hkgL5E+mE+OM49VLHZ/l38R1
         UYf99bE8/vmDxL4LI5j1WFbnLCVM82wFWeLqEAhNtpsOgJz8JfHhtw9gmYkBikC2qh1Y
         oK1uHa5ulcS3hMhI4iDd08MJ/6h/h3zXdJS5Or9ECXDwjFeRy1twUJ3fQohCq2f0CI1P
         HdyA==
X-Gm-Message-State: APjAAAXGkmfRNXVJ725okAihcqFCFLXRrk4kxrshGpIX45quoIUk7fGB
        sqrI0PhZQkzHJhEeJkiz0zW/DQ==
X-Google-Smtp-Source: APXvYqxB6P7419QyyFKVgH6l5TwY0Bz0HEi+pPLFF7AI0St9nOu8VH7oWOLKjOf3r6TWOwV8MSbd5A==
X-Received: by 2002:a17:90a:b002:: with SMTP id x2mr30861200pjq.38.1577516593601;
        Fri, 27 Dec 2019 23:03:13 -0800 (PST)
Received: from [25.170.118.188] ([172.58.27.172])
        by smtp.gmail.com with ESMTPSA id m6sm16495444pjv.23.2019.12.27.23.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 23:03:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Date:   Sat, 28 Dec 2019 15:03:09 +0800
Message-Id: <FF35B317-0AE9-46AB-A829-3C94E5598A1C@amacapital.net>
References: <20191228063531.GB1194635@rani.riverdale.lan>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20191228063531.GB1194635@rani.riverdale.lan>
To:     Arvind Sankar <nivedita@alum.mit.edu>
X-Mailer: iPhone Mail (17C54)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On Dec 28, 2019, at 2:35 PM, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>=20
> =EF=BB=BFOn Sat, Dec 28, 2019 at 01:29:00PM +0800, Andy Lutomirski wrote:
>>=20
>>> * The stack must be 16-byte aligned
>>=20
>> Nope. The asm needs to do this for runtime services. The kernel runs with=
 8-byte stack alignment.
>>=20
> 32-bit code is actually only 4-byte aligned in the kernel proper, right?

Right. By =E2=80=9C8=E2=80=9D I meant =E2=80=9Clong=E2=80=9D.  Sorry.

>=20
> Currently, only native 64-bit calls always respect the 16-byte alignment
> requirement, by aligning explicitly in the asm stubs, or after the
> cleanup patches, via the efi bootloader running with 16-byte stack
> alignment.
>=20
> I think mixed mode might actually be aligned via the asm stub in the
> kernel proper, though it doesn't look like it is in the bootloader
> portion.

The underlying problem is that gcc doesn=E2=80=99t give us a way to do CALL f=
rom asm while preserving more than a single word of alignment. This forces u=
s to compile the kernel proper with reduced alignment.  (Also, the generated=
 code is better with reduced alignment.)=
