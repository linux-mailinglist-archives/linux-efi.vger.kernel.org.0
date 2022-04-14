Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3A500B01
	for <lists+linux-efi@lfdr.de>; Thu, 14 Apr 2022 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiDNKZL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Apr 2022 06:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiDNKZJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 Apr 2022 06:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5776677;
        Thu, 14 Apr 2022 03:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C12461E59;
        Thu, 14 Apr 2022 10:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B63C385B2;
        Thu, 14 Apr 2022 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649931764;
        bh=UP2ZdlXMZjXTQwi2bJVC42wnwXESiNxV1SL51CcDxJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OwL4J0kxyO6/5LiiQ7Fj4OWwPgPnYkCayAcCWbenxuYiR+T0tK5VcfU6yj7iPNDe8
         1ji7CgCJiaVHoDuF9HKf/Oh0Xs9Q+p4eukEtKLVZ5bCHMWQR4q0vVaGtbI/aiYsbPb
         qq4vw4cKxN4d6J5QrHuR2MOkRKjKMY4wCsQo0HEaqPz5X8wKNWnS3gW9ZNezd/eZFM
         Qbox1JvOQvUUyMNH0L7kr3XAhc2hBdDlLiTM3Vv9rovjsyaTLZhQ2to83DIcBiAdoM
         DKwPiibbJbfioGbgjHs4mPbEivr+cLG9G+DY6H7g9y9E/ADZc8f3TtxI/ysKmUKTRK
         g6Tjh7RJXoMdg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-dacc470e03so4805887fac.5;
        Thu, 14 Apr 2022 03:22:44 -0700 (PDT)
X-Gm-Message-State: AOAM533vkO99tEOYGZYmsC9jH+/jJpuMfJnbZiCA2PqQbYcWjPeszpBs
        TE1Kz03nhmD1veQdeUynbvIvwIdtNr3YjzAzgwU=
X-Google-Smtp-Source: ABdhPJwuW/8OUefFVmTgDz0hNVBCeNt8JTQEdxC3MramBRSaVXc+L6rpKEN0PLTlAXUWxqPUmRp0FgtWen5kuG48Mns=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1308766oap.228.1649931763538; Thu, 14
 Apr 2022 03:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220414101314.1250667-1-mawupeng1@huawei.com>
In-Reply-To: <20220414101314.1250667-1-mawupeng1@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Apr 2022 12:22:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
Message-ID: <CAMj1kXGSStDgj9ABmUaTLnBmpQFksh3wx4tx=mJohum4GQe3Gg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] introduce mirrored memory support for arm64
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, hpa@zyccr.com,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, songmuchun@bytedance.com,
        macro@orcam.me.uk, Frederic Weisbecker <frederic@kernel.org>,
        W_Armin@gmx.de, John Garry <john.garry@huawei.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        chenhuacai@kernel.org, David Hildenbrand <david@redhat.com>,
        gpiccoli@igalia.com, Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-ia64@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 14 Apr 2022 at 11:54, Wupeng Ma <mawupeng1@huawei.com> wrote:
>
> From: Ma Wupeng <mawupeng1@huawei.com>
>
> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory ranges")
> introduced mirrored memory support for x86. This support rely on UEFI to
> report mirrored memory address ranges.  See UEFI 2.5 spec pages 157-158:
>
>   http://www.uefi.org/sites/default/files/resources/UEFI%202_5.pdf
>
> Memory mirroring is a technique used to separate memory into two separate
> channels, usually on a memory device, like a server. In memory mirroring,
> one channel is copied to another to create redundancy. This method makes
> input/output (I/O) registers and memory appear with more than one address
> range because the same physical byte is accessible at more than one
> address. Using memory mirroring, higher memory reliability and a higher
> level of memory consolidation are possible.
>
> Arm64 can support this too. So mirrored memory support is added to support
> arm64.
>
> Efi_fake_mem is used for testing mirrored features and will not be used in
> production environment. This test features can fake memory's attribute
> values.
>
> The reason why efi_fake_mem support is put first is that memory's attribute
> is reported by BIOS which is hard to simulate. With this support, any arm64
> machines with efi support can easily test mirrored features.
>
> The main purpose of this patchset is to introduce mirrored support for
> arm64 and we have already fixed the problems we had which is shown in
> patch #5 to patch #7 and try to bring total isolation in patch #8 which
> will disable mirror feature if kernelcore is not specified.
>
> In order to test this support in arm64:
> - patch this patchset
> - add efi_fake_mem=8G@0:0x10000 in kernel parameter to simulate mirrored
>   memroy between phy addr 0-8G.
> - add kernelcore=mirror in kernel parameter
> - start you kernel
>

As I explained before:

- NAK to EFI fake_mem support on arm64
- NAK to the whole series until you come up with a proposal on how to
locate the static kernel image itself into more reliable memory, as
there is really no point to any of this otherwise.
