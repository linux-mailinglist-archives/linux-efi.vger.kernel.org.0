Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4336B30EE8C
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 09:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhBDIet (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 03:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhBDIes (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Feb 2021 03:34:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B12E64F45;
        Thu,  4 Feb 2021 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612427647;
        bh=RquHUleAQq/EWfHv9LMTemp+Pq3SAitkeZFoJKpQtt4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fiF8XFO7dpqCQK/x/SzT9+Ogkd0xkmoJaAOhGLBTtKHqBo+8jWWhyKoEavNKKxSvL
         IOf4a3BzVy/dGH3DpFrEUmwsKWSxOUa9kJt8iQW3JxxioBdwUQZ/iXXrwvAGglNkqX
         3R3iAI2Qvu+1r0IsoLomTFaCnydLme2KV55LLxzi3xHyhgqeAo14uk1zXafYiJgVXv
         tPcC4mY27l9ngOI8Dj+um4MP0p2kFJv+582dWuG0830kTQpr5yDkvXdYWDzXY1wGgB
         CZbesk1ietEA6Sdyq4aWZID2XtM2jK9zg6TYR+0VZFv4+ksb05afDct2NPvVH4LDpx
         Ii4aaV416g8qQ==
Received: by mail-oi1-f172.google.com with SMTP id u66so1003033oig.9;
        Thu, 04 Feb 2021 00:34:07 -0800 (PST)
X-Gm-Message-State: AOAM530zFRL3VKlryVdb46RmmEo3tApd4NG+AhzHjQryN7IkVc09plPV
        Sd7Mar5Zh57YpCbeFWVJKeVOWmVfK5/UZeT1trI=
X-Google-Smtp-Source: ABdhPJxi10SMp/4uoVGE9S9Q9C/QUWkZk1L7nvBLQ9ra3MPo1ATUd7RfVUhnXeSAVLO8u4SO10W4nUuc26qlOWq+/rc=
X-Received: by 2002:aca:110b:: with SMTP id 11mr4452416oir.174.1612427646896;
 Thu, 04 Feb 2021 00:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20210118124913.1555-1-ardb@kernel.org> <f32b7560-4de4-79bb-a2e2-4edcb2a9d475@physik.fu-berlin.de>
In-Reply-To: <f32b7560-4de4-79bb-a2e2-4edcb2a9d475@physik.fu-berlin.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 09:33:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGMzrrEnNfv-cf+fG3snSMDuud48tX1pEZKst9jODkiQw@mail.gmail.com>
Message-ID: <CAMj1kXGMzrrEnNfv-cf+fG3snSMDuud48tX1pEZKst9jODkiQw@mail.gmail.com>
Subject: Re: [PATCH] efi: ia64: move IA64-only declarations to new asm/efi.h header
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 4 Feb 2021 at 09:26, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Ard!
>
> On 1/18/21 1:49 PM, Ard Biesheuvel wrote:
> > Move some EFI related declarations that are only referenced on IA64 to
> > a new asm/efi.h arch header.
>
> I will test these changes later this week. I guess they will make it easier
> to drop ia64 support from the kernel if that gets decided in the foreseeable
> future.
>

Hi John,

That is one aspect of it. Another aspect is that the lack of a
asm/efi.h header created some problems in the past, given that all
other EFI architectures do have it.

But the most important reason is really that arch-specific definitions
for an obsolete architecture should not be visible in other builds.

-- 
Ard.
