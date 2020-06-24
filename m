Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60C8207A38
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405523AbgFXR0Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Jun 2020 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405450AbgFXR0Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Jun 2020 13:26:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31EEC061573
        for <linux-efi@vger.kernel.org>; Wed, 24 Jun 2020 10:26:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so1315850plr.4
        for <linux-efi@vger.kernel.org>; Wed, 24 Jun 2020 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MnQWlAViaAXgR6ChKk9flTU7iy/dP/Hqi3HZ30RWfcA=;
        b=HHUTbvXU8iaNylfrBu2tKAp6t8jvzwGxJv4iQWDRdjnhiP1bSVaMJy3y6z9hlDLo5j
         I3r9BcePoZxu3+e/4tWyl+hlZf6p8Dk3oi6OlIpMi2Bre5oCdOktwagNmvSvXj80p45/
         qBNen7/kYI5dyPaI7TzcMXBYWgXUQStxnApBoGkLKlQUqKFCWrKmo07mBmRdo2Uq2UAY
         SnhyDTWHaTW4W99fdN1AYeItiGEhnJVPXK8z9+1eONtpAatxhfK1DAjRnTnibVGkHFqt
         SVfUg2fkin8g64ceJ6gtvnSPvBarq4d7rDD5V6XBCFnHYOlfMrs3xzt1x+d3BckHFWC3
         AeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnQWlAViaAXgR6ChKk9flTU7iy/dP/Hqi3HZ30RWfcA=;
        b=OFBLyegPmQMWnPdkY734DKO7Hfsp1U/Emq8TrgFvgiNKRfMmICuxXWMEC0PMvpJcIu
         Pf6EnFcxcx0XYHSUO2vAUsVuYpy1Q08RnVGE4ve3qxV9QD7mKkp+hqsFDjUQd8V0cIbg
         dtmpVNy/ij/8x60hk6K3GZlCrXLuj6/0ZjLCs4srWAlSDe7oqEjO/XBQq2I1c1wbtAi1
         zc9GxxvDfDnvamlWAlitnPrnHxslf/fjlnl7f0/eFtKRKoEwCFWUfuNa2YacrN0wwEMg
         e4XQf/TPWJe2CaPsLxpdR3yssK5cwdGZh5cHoZ39Zt/2v4vPO8CPHXAI5aFDVyeMcnQ3
         t38Q==
X-Gm-Message-State: AOAM53211i2jX1h8e5g5zXbueAWJIOFq1C76yv+zqVwxr3XifysMhC+n
        NwCQqFQQMg8kizVH2NuQxlgYRw==
X-Google-Smtp-Source: ABdhPJy/02NChU1UMXqYAoZX4iMBIryqEQ4wkk5JgSfgSZouk+nUj0lvwCKX2dompigE5x6ivL/uXg==
X-Received: by 2002:a17:90a:f3d6:: with SMTP id ha22mr29151692pjb.193.1593019583946;
        Wed, 24 Jun 2020 10:26:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id i191sm21217005pfe.99.2020.06.24.10.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:26:22 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:26:20 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vmlinux.lds.h: Add .symtab, .strtab, and
 .shstrtab to STABS_DEBUG
Message-ID: <20200624172620.654hhjetiyzpgoxw@google.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
 <20200624153930.GA1337895@rani.riverdale.lan>
 <20200624161643.73x6navnwryckuit@google.com>
 <20200624171121.GA1377921@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200624171121.GA1377921@rani.riverdale.lan>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2020-06-24, Arvind Sankar wrote:
>On Wed, Jun 24, 2020 at 09:16:43AM -0700, Fangrui Song wrote:
>>
>> On 2020-06-24, Arvind Sankar wrote:
>> >On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
>> >> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
>> >> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
>> >> so there will be no warnings when --orphan-handling=warn is used more
>> >> widely. (They are added above comment as it is the more common
>> >
>> >Nit 1: is "after .comment" better than "above comment"? It's above in the
>> >sense of higher file offset, but it's below in readelf output.
>>
>> I mean this order:)
>>
>>    .comment
>>    .symtab
>>    .shstrtab
>>    .strtab
>>
>> This is the case in the absence of a linker script if at least one object file has .comment (mostly for GCC/clang version information) or the linker is LLD which adds a .comment
>>
>> >Nit 2: These aren't actually debugging sections, no? Is it better to add
>> >a new macro for it, and is there any plan to stop LLD from warning about
>> >them?
>>
>> https://reviews.llvm.org/D75149 "[ELF] --orphan-handling=: don't warn/error for unused synthesized sections"
>> described that .symtab .shstrtab .strtab are different in GNU ld.
>> Since many other GNU ld synthesized sections (.rela.dyn .plt ...) can be renamed or dropped
>> via output section descriptions, I don't understand why the 3 sections
>> can't be customized.
>
>So IIUC, lld will now warn about .rela.dyn etc only if they're non-empty?

HEAD and future 11.0.0 will not warn about unused synthesized sections
like .rela.dyn

For most synthesized sections, empty = unused.

>>
>> I created a feature request: https://sourceware.org/bugzilla/show_bug.cgi?id=26168
>> (If this is supported, it is a consistent behavior to warn for orphan
>> .symtab/.strtab/.shstrtab
>>
>> There may be 50% chance that the maintainer decides that "LLD diverges"
>> I would disagree: there is no fundamental problems with .symtab/.strtab/.shstrtab which make them special in output section descriptions or orphan handling.)
>>
>
>.shstrtab is a little special in that it can't be discarded if the ELF
>file contains any sections at all. But yeah, there's no reason they
>can't be renamed or placed in a custom location in the file.

https://sourceware.org/pipermail/binutils/2020-March/000179.html
proposes -z nosectionheader. With this option, I believe .shstrtab is
not needed. /DISCARD/ : { *(.shstrtab) }  should achieve a similar effect.
