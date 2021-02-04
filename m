Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123BA30EF96
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhBDJXJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 04:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234686AbhBDJWy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Feb 2021 04:22:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A586C64F51;
        Thu,  4 Feb 2021 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612430533;
        bh=rFIQPTl5AXZFJafJ71pTcT0Gs1F5LBvg098iSoUYamg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AI9UjnEEnCi4HOC6gpsH944EwH97HSPb+4pOCqb+kzmEfnO18nH97iHhQ/YLVYjcz
         sflgVGyo61CXQu78Hdb6Ttqaq8hKohlnIwap3ZuYJrln2ArK3RMT2ZXPYIQA7bs/iN
         olLdv5VHDn73JOKMGgZgrzzVS3ZLmPSpPPgeslQ7BmX5pyNGDW5p0QjsPnocaHEYMs
         bIuM1JLiNufAi8GNuu0Xatn97aPqgjsVWOVNk7YpZ5B6v8fTUwnFKlkVpd5toB7x+k
         vO0Vgl/LWpsrtE6STNCth7Hc9MTA0BzwC8ecgsS6J5/YD+qNxlu40pNc9xc5AFgMx3
         wPRNoUIAh4tJA==
Received: by mail-ot1-f53.google.com with SMTP id s107so2717626otb.8;
        Thu, 04 Feb 2021 01:22:13 -0800 (PST)
X-Gm-Message-State: AOAM5307RVMppTBe8Kczw+lJNyitDif9o9+z/ESe3559FHHNmPcoZan8
        b7sZYSz4kPlcoWG/40aeCFkTlcoXJy8Kg7UQr+I=
X-Google-Smtp-Source: ABdhPJy0xnoXC0kcVix3fWhT6X0spxJQr2RgVO7JQbWbIjDM7c3Hs6HD+wKDmnp179aZ6DKUaXoGW//LmTCw6F/UPKc=
X-Received: by 2002:a05:6830:1614:: with SMTP id g20mr4943139otr.77.1612430532901;
 Thu, 04 Feb 2021 01:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20210118124913.1555-1-ardb@kernel.org> <f32b7560-4de4-79bb-a2e2-4edcb2a9d475@physik.fu-berlin.de>
 <CAMj1kXGMzrrEnNfv-cf+fG3snSMDuud48tX1pEZKst9jODkiQw@mail.gmail.com>
 <294348ae-c87a-3bc1-3593-e0c7982fe7d7@physik.fu-berlin.de>
 <CAMj1kXEOR5d7Hva7_=RkaoZw9A3ZBe-6otAL-C9YvL7FHe9+NQ@mail.gmail.com> <f8252e56-41ab-e89d-93bf-972cf0bc100b@physik.fu-berlin.de>
In-Reply-To: <f8252e56-41ab-e89d-93bf-972cf0bc100b@physik.fu-berlin.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 10:22:01 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEDTLHyECC3yrfQ6Hgw1m9NB1GnNB=dO229To-goE6vmw@mail.gmail.com>
Message-ID: <CAMj1kXEDTLHyECC3yrfQ6Hgw1m9NB1GnNB=dO229To-goE6vmw@mail.gmail.com>
Subject: Re: [PATCH] efi: ia64: move IA64-only declarations to new asm/efi.h header
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 4 Feb 2021 at 09:44, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On 2/4/21 9:40 AM, Ard Biesheuvel wrote:
> > Actually, I have already sent this patch via the EFI tree, and it is
> > already in -next.
>
> OK, I'll test it nonetheless and report back.
>

Thanks John.

Would you mind if I cc you in the future on EFI patches that may affect IA-64?
