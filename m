Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77D4770F0D
	for <lists+linux-efi@lfdr.de>; Sat,  5 Aug 2023 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjHEJZp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Aug 2023 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHEJZn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Aug 2023 05:25:43 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60C10CA
        for <linux-efi@vger.kernel.org>; Sat,  5 Aug 2023 02:25:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F35A640E01E6;
        Sat,  5 Aug 2023 09:18:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F44GW5dpf85V; Sat,  5 Aug 2023 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691227078; bh=AX17IsjWs1wvCdpan7Z6cB5tCZ+nkFjypGCrx0zZWWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjmfrOdCMiReVXUtSgbKkcELpVKnElf2p6URQNv3oZgYrXnXsreH38hdp6EqaDTuh
         dznglyyAoRGNBNd6Ic5wXuH6PaXe+4hgcFzXx0QWlds5Q7hh6aR6qG5sOVoL8w0JOw
         B84gmm9uAryZ201SFIZalXgiTm843BQeb+5+KpOrP+wJYHLDpgnTFxv/V/WGb6mUIw
         LC1EjJflSN4s1YMpeKJJB0L8QqnjzApeRtlbWqeEaQHmWbQn+QpivU0b7namA+qV0z
         AkEpVjpYCrmRaxdTcHGzRsYI0A5Olyg34O5CXIi/K2++CMcGGT3KAyguNbFzOIXLV3
         /Y3EP0KOy/NSKsdvKsDjT4HWUMY1ccz7gWcur0E79SgzbF+Qban4Vi8Gng1DsIFz+G
         A/parmDJwv3zjjb2N1FlOdYPjDEIII9aB8XqGREPgN1xnN0QCNsJJ91jz5J1sqe4R5
         pPzY6ZCd4AZ/w7r2C2x9HzKQzB5H/V0fwk9MGKo/tfmGzznFGuZI8j1J2Aw2AMG0+6
         wQLOdT0hZq/g3akwzT546qPo49Jos4m15YnUnzItQfiFQbTZZvAepyXUfc8n/PzAz1
         mIKUN4NTCHp73dr5//xQx3jgemf1op8+zPEoXlvBnK51PaNmeQA4P4sy7r4ftkpqIw
         0D/sB6U9LxC4s5JFZlW1S/m0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A5BD740E019D;
        Sat,  5 Aug 2023 09:17:43 +0000 (UTC)
Date:   Sat, 5 Aug 2023 11:17:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tao Liu <ltao@redhat.com>, Michael Roth <michael.roth@amd.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230805091738.GAZM4TslVWR3HHKeUC@fat_crate.local>
References: <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local>
 <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
 <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
 <20230802093927.GAZMokT57anC5jBISK@fat_crate.local>
 <99cb3813-1737-9d10-1f24-77565e460c55@amd.com>
 <20230802135856.GBZMphIHHLa3dXRRVe@fat_crate.local>
 <CAMj1kXEM5hGknVGwHh_w99D4L8yrYrTFycwGHZ0CQun70CLipw@mail.gmail.com>
 <20230802155146.GCZMp7ksDdN2ETVzKV@fat_crate.local>
 <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnSzdQw5CMAVXU7EzpnrdRvAqKZVgA+EV35kHmwVULgQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 03, 2023 at 01:11:54PM +0200, Ard Biesheuvel wrote:
> Sadly, not only 'old' grubs - GRUB mainline only recently added
> support for booting Linux/x86 via the EFI stub (because I wrote the
> code for them),

haha.

> but it will still fall back to the previous mode for kernels that are
> built without EFI stub support, or which are older than ~v5.8 (because
> their EFI stub does not implement the generic EFI initrd loading
> mechanism)

The thing is, those SNP kernels pretty much use the EFI boot mechanism.
I mean, don't take my word for it as I run SNP guests only from time to
time but that's what everyone uses AFAIK.

> Yeah. what seems to be saving our ass here is that startup_32 maps the
> first 1G of physical address space 4 times, and x86_64 EFI usually
> puts firmware tables below 4G. This means the cc blob check doesn't
> fault, but it may dereference bogus memory traversing the config table
> array looking for the cc blob GUID. However, the system table field
> holding the size of the array may also appear as bogus so this may
> still break in weird ways.

Oh fun.

> I don't think we can kill it yet, but it would be nice if we could
> avoid the need to support SNP boot when entering that way.

That's what I meant - not boot SNP guests through the 32-bit entry path.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
