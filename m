Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7C6829D4
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 11:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjAaKCO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Jan 2023 05:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjAaKCE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Jan 2023 05:02:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A8B4B1B0;
        Tue, 31 Jan 2023 02:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE326148D;
        Tue, 31 Jan 2023 10:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78610C433D2;
        Tue, 31 Jan 2023 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675159316;
        bh=zZNlLghw6V9wEXXq5DkKqOM2d+4MNtK2XkOLQMjr+wU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q26pxu2aUlnFzusmXrTZHJj3CDAS/rkUDFuJ1JFwQwxWIyArIMb1a4Rbz/xqvrPfK
         ryr60BW7Va5SGPHU5nerTHTkdO/jXzQP9Sx/Xl7BnZARDm8uot8ZVSMqjyRyeUMs74
         OtFGPDETSTJS7Ry/RTdNQqB8WE+xPPqeuSyJWqrcw7X1rJnuBInkvXvT5MxVa8FXbb
         PRaFO39kR6xevq1P5wqiy5fM/N/i/BQNvuR15EaTvXEv4sUQCGvthtEbduuPn3mrTb
         DeZCO9kmUeH6Wr0KOBbbrtaaJcbBTr4ryhRiuqOscxOmBjfPkgsOegjxtMdCyrEp+b
         GVQIkQzwS0o5Q==
Received: by mail-lf1-f41.google.com with SMTP id v17so17506739lfd.7;
        Tue, 31 Jan 2023 02:01:56 -0800 (PST)
X-Gm-Message-State: AFqh2kpSN9dZrnc/3k7z+qC8wYXYU3CmeQYUHrDtaxnS6JIiSttg3g57
        jCD+ZJ4U5sN3af99WdZaekeOgNkv13pt5Mx9zDw=
X-Google-Smtp-Source: AMrXdXtLAtEr3IEY2nAOxnGMXcmekU+fLGyPY//2QVEGJ4Ts1ZyGHjsjSfQ5yah6bmFlwNm8gToLE2PQPgYB4ELyLbw=
X-Received: by 2002:ac2:4bd3:0:b0:4cc:789a:dac8 with SMTP id
 o19-20020ac24bd3000000b004cc789adac8mr6619563lfq.198.1675159314541; Tue, 31
 Jan 2023 02:01:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668958803.git.baskov@ispras.ru> <44539c8c6afdba66f791942deae95c7b13d1e13b.1668958803.git.baskov@ispras.ru>
 <CAMj1kXF5tE+vj_Kf_z=KTqoi12PBq5g5Ds+097w9ge+U4NQong@mail.gmail.com> <c3dcdf14c51adfa7558eeaec4378287e@ispras.ru>
In-Reply-To: <c3dcdf14c51adfa7558eeaec4378287e@ispras.ru>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 31 Jan 2023 11:01:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF3W6q0Xwb0BuBGAHGQ0keehz1eEeNyRiy9-_zajdnfBA@mail.gmail.com>
Message-ID: <CAMj1kXF3W6q0Xwb0BuBGAHGQ0keehz1eEeNyRiy9-_zajdnfBA@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] efi/libstub: Add memory attribute protocol definitions
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 31 Jan 2023 at 11:00, Evgeniy Baskov <baskov@ispras.ru> wrote:
>
> On 2023-01-31 11:37, Ard Biesheuvel wrote:
> > On Tue, 22 Nov 2022 at 12:14, Evgeniy Baskov <baskov@ispras.ru> wrote:
> >>
> >> EFI_MEMORY_ATTRIBUTE_PROTOCOL servers as a better alternative to
> >> DXE services for setting memory attributes in EFI Boot Services
> >> environment. This protocol is better since it is a part of UEFI
> >> specification itself and not UEFI PI specification like DXE
> >> services.
> >>
> >> Add EFI_MEMORY_ATTRIBUTE_PROTOCOL definitions.
> >> Support mixed mode properly for its calls.
> >>
> >> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
> >
> > I have fixed up just this patch, as there is another user for the
> > protocol in zboot.
> >
>
> One patch less in the patch set then, thanks!

I meant queued up not fixed up, but you get my point :-)
