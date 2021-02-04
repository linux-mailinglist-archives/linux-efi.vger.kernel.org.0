Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1070930EEA1
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 09:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhBDIlS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 03:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234897AbhBDIlR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Feb 2021 03:41:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0996864F51;
        Thu,  4 Feb 2021 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612428037;
        bh=gu8FbHVjnX+1BDuqDKOTnq1/uJd027GIrEC3wa7yz3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f9kzrWMZyXIfKSuNIYd9KdufMtACh9jkgnR0PuwJdbQLMi0lE/zVoPm7ntf21JAdN
         TEX83wCrSAojbj86KLNOd5ip2yU1ygWkJcjSOTljTQL8lJ8/zdG1rIyUFBezJerjRL
         UvIGx9IkJ3Hla8oGAeNYvHavBv+4JxxGTmru0j882AdWGlCclZwVZ+DzqszYvt4sPI
         5FkQKstkcssHngv25fEe/MS9WrQI4dOO0SjaKYXQYNBh2tWwEhIA37s8iK6XCrWA0q
         +eVK4UwxnzaEgS/BQQHUGJhxduVN6JbCQcfYmOmHf6yCZUMAfzgh8fO8nOzn1cYRbR
         SiHTrQ4crp1Pw==
Received: by mail-ot1-f42.google.com with SMTP id f6so2625471ots.9;
        Thu, 04 Feb 2021 00:40:37 -0800 (PST)
X-Gm-Message-State: AOAM532aDoaSOoluMKutHr2i1tARwaUJL1j4g3x4WXXPwaMNHncrh+Tm
        IMp2GLV4mUuQpwUpL3V0vMq/+aUsUycpR/ME3zo=
X-Google-Smtp-Source: ABdhPJwkt9wH1VpOQnwrTcawh8Fr2OkcpsZLdAI3gHDIWRwNecGRWTGpEDdVtyjeOhxrn7uSPANMs0DBk1dKcIy4DjA=
X-Received: by 2002:a05:6830:1158:: with SMTP id x24mr4776054otq.108.1612428036325;
 Thu, 04 Feb 2021 00:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20210118124913.1555-1-ardb@kernel.org> <f32b7560-4de4-79bb-a2e2-4edcb2a9d475@physik.fu-berlin.de>
 <CAMj1kXGMzrrEnNfv-cf+fG3snSMDuud48tX1pEZKst9jODkiQw@mail.gmail.com> <294348ae-c87a-3bc1-3593-e0c7982fe7d7@physik.fu-berlin.de>
In-Reply-To: <294348ae-c87a-3bc1-3593-e0c7982fe7d7@physik.fu-berlin.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 09:40:25 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEOR5d7Hva7_=RkaoZw9A3ZBe-6otAL-C9YvL7FHe9+NQ@mail.gmail.com>
Message-ID: <CAMj1kXEOR5d7Hva7_=RkaoZw9A3ZBe-6otAL-C9YvL7FHe9+NQ@mail.gmail.com>
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

On Thu, 4 Feb 2021 at 09:39, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Ard!
>
> On 2/4/21 9:33 AM, Ard Biesheuvel wrote:
> > That is one aspect of it. Another aspect is that the lack of a
> > asm/efi.h header created some problems in the past, given that all
> > other EFI architectures do have it.
> >
> > But the most important reason is really that arch-specific definitions
> > for an obsolete architecture should not be visible in other builds.
>
> I fully agree. I try to test your patches over the weekend. Since Tony
> is not active anymore, we need to get the patches pulled in through
> someone else's tree. Probably Arnd or Mike (both CC'ed).
>

Actually, I have already sent this patch via the EFI tree, and it is
already in -next.
