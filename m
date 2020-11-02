Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED652A3513
	for <lists+linux-efi@lfdr.de>; Mon,  2 Nov 2020 21:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKBU0e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Nov 2020 15:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgKBU0e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Nov 2020 15:26:34 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D96C0617A6
        for <linux-efi@vger.kernel.org>; Mon,  2 Nov 2020 12:26:34 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id t13so6184117ilp.2
        for <linux-efi@vger.kernel.org>; Mon, 02 Nov 2020 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UBnYybDxXvPlQ/FR6bDYRXI+aV3UeFYSYbyqFSO9/oQ=;
        b=mJ+UyhqMb5Yoo3N8hS4hn2bmK0n7MG3mtB8XPL4H7L0jhg0nKDW1mv0bxRIbY5b1fF
         cgjkSTIW4iwxSba2aEWhjMQUxBJCO16mL8dr+zNh2l0kcj51/n00FXOYlOlrK/eX1Kha
         XR5WysWkNpUKX68GvoEub8y72D9blnKgdNh+5MICL0fomNO/wOxQy+oQS30N0MYxcJgc
         c1lzReOosp4qxppEuHVOaA34tnoG40RZQFOZXgOAHEfRazJS0kTyhaidYZ2kFIq9tXoB
         9eVDpszitGAY8cb3o3vagJDqEPrr0ULJkaK6RJEuzckGd+d+593BmFl38q2CDu7hPbVW
         l0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBnYybDxXvPlQ/FR6bDYRXI+aV3UeFYSYbyqFSO9/oQ=;
        b=HyylQyDqBHNyi40IJjFMDlO8vNQ81UY5bd6Irqm3ZkRrAnKLzx0y4lLtB6TWUhf3t4
         atDFy2/UzaEpB+qkZHpU1gnXsaq+L0yFT7RwmoLeW01q/FbnpkEVZ2nkMxwCn5p1+spl
         MNIdFY1S/CPSzp/WXnLJ1IVfh3jppu8ti8agEKCtUS/nne8yyZj7bDgOBBh2Ly4DazyX
         Xk7KyXU/873TpwFp8zXyddPLGQxmwpHCMIcm1NYlt0modgH3xrUTCFlfgbvdtm3AhxeP
         JMbHPIuPLWSLGtTURx9CTF866B65pRTcbRCQnsFdrgdFniCAlH8h4SUPxR3Z3H5UYnpQ
         aRXA==
X-Gm-Message-State: AOAM532H8AiZyJombH9jkSDfR0pHDRg9Ewzq4cFh3ed2PF6TvMAdfQo7
        uAldPk2E25vQNjKlNGdovtxYJ8RqajRXqhdxcwWSeA==
X-Google-Smtp-Source: ABdhPJy2dqn9/azAiFqQgvgb39MPjgloHef4Wta+tDac9NRmWVd5FfQQz2+cPIxsnVJ2duzRCKIXRgUuYsH7dQlJ7gE=
X-Received: by 2002:a92:98c5:: with SMTP id a66mr12383942ill.50.1604348793613;
 Mon, 02 Nov 2020 12:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20201102170634.20575-1-ardb@kernel.org> <CACdnJuvC3EjQb5ZfOBynNzMPOwUm3w5CnXDCYGd10w_AW+_efw@mail.gmail.com>
 <CAMj1kXGXOb3Q9mwK7dGbhmTbN_82m7BBYW+0ATVmG59LK3N++A@mail.gmail.com>
In-Reply-To: <CAMj1kXGXOb3Q9mwK7dGbhmTbN_82m7BBYW+0ATVmG59LK3N++A@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Nov 2020 12:26:22 -0800
Message-ID: <CACdnJuuG2Zout7swB4su2wVJHan5B84wshFHit2L58pbYndmjg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by
 the EFI stub
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 2, 2020 at 12:24 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> Does Shim use PCR 7 for the MOK key database? Are there any specific
> requirements from MS on which PCRs Shim must touch?

Yes, shim extends PCR 7 in the same way the firmware does. There's no
requirement from MS on this, it just seemed like the right solution.
