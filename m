Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE731D9AB1
	for <lists+linux-efi@lfdr.de>; Tue, 19 May 2020 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgESPGd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 May 2020 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESPGd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 May 2020 11:06:33 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDCCC08C5C0
        for <linux-efi@vger.kernel.org>; Tue, 19 May 2020 08:06:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r3so6658862qve.1
        for <linux-efi@vger.kernel.org>; Tue, 19 May 2020 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vdEPEt8RsJ0oPDmoGl5+ixm27tXkFLm/r/LEFpuJdIQ=;
        b=qzut2bCP4+oG1BRgNxwv/LiiQhSxzF0pgpSlerOR+bzJSflwC/CE5FAuCOho1j1fBj
         qbL4MxAXz2x6AIXqfaayvxXD7t16x6IcmZpQblyLepdr+bj2Py2QeIfommxOPEagFCO6
         SHooUFEgdiwsPQcMJoa0M03GUP0A6Tz+wZ1k1hf//yzl2NjPirlMMZVj8WXbxhzXrcdo
         p3ALqAyKGTPIcPb2KRChvBsSE2p4RwgvJAUtdtK07I7qMfqgHtCBzsfEiwEnO70i6VQh
         esCy96ocsZYgfI/D5/eVoFE+ZoqUovpqOaUAaXm+r7PW6hVs1fd4PB/e0JglXuTOEwLG
         oVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vdEPEt8RsJ0oPDmoGl5+ixm27tXkFLm/r/LEFpuJdIQ=;
        b=k1yWRi6W4cTtRDymqTwvpO7ykSQyNyGuVhqKEI5rYdSM2oy7IGRBjdJWk/4Z0NyEfe
         UG3gCMMR6gyKm7gcGXQxjfObkDT/xrEjCBPTLoQhyqJ1ZOo19u6s+4yCfAkcJWU/and4
         WQHgZZQxU91tNHZ49+wPz+lbm3eCzh7izNk1Q9KMO8i/vjzzAT4MCuckMQW8/MT63m7W
         rltjiKIaTc1WYn+o/El/lIcN+6/4CL1tIwtZUWRgoTzD53sS70E/c3HtZvz2hPC6K57C
         u254Iae+Becl1n7CWYBjAuCeJ5CtZ1sLe6CfFiZBtdH8Nq2UOVhUum7NSx0kbDrfbwkP
         Og7w==
X-Gm-Message-State: AOAM533rYMbVe3gIye8Tzs2r1c4RU0PPzi8EupTtLDXoS9dnbCQWGafV
        +9p/61jfkO27cnnwsdmPEuI=
X-Google-Smtp-Source: ABdhPJz/uZUEajWsndqYqptvVj3BJigLodXxlY+w08d5XovW8cNQXSAKT+gAt1J5sX4t8yrGWiRaMA==
X-Received: by 2002:a05:6214:6a7:: with SMTP id s7mr5067qvz.142.1589900792198;
        Tue, 19 May 2020 08:06:32 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n35sm12074008qte.55.2020.05.19.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:06:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 19 May 2020 11:06:29 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 00/24] efi/libstub: Add printf implementation
Message-ID: <20200519150629.GB1526900@rani.riverdale.lan>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <CAMj1kXE7EasnCLW0LrWP7f8A9dpTThSHJUP+iM-i0Tqrm=FoOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXE7EasnCLW0LrWP7f8A9dpTThSHJUP+iM-i0Tqrm=FoOA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, May 19, 2020 at 09:53:47AM +0200, Ard Biesheuvel wrote:
> 
> Thanks Arvind, this is looking really good!
> 
> Did you use any test code for the printf() parsing? Given that the
> kernel command line is not covered by secure boot signing (or the
> initrd, come to think of it), I'd hate to open up a security hole
> here.
> 
I only did basic functional testing, I haven't tried to actually break
it.

I think the code will be robust enough to avoid overflowing the buffer
passed to vsnprintf, even if the output ends up being garbage due to
bugs.

That said, one thing in efi_convert_cmdline is that we use int to hold
both options_chars and options_bytes. The size of load options is
limited to uint32, so int should be ok for options_chars but
options_bytes could theoretically overflow?

In any case, there's no point parsing beyond COMMAND_LINE_SIZE anyway,
so we should limit options_bytes to COMMAND_LINE_SIZE-1 + terminating
NUL, and if it's longer we can either truncate it (blindly or at
whitespace?) or ignore the options altogether. I can add that in v2.

One more question -- since the first version of the stub, we truncate
the command line at the first newline character. Do you know if there's
something that actually needs that?

efibootmgr can actually even set up the load options as a series of
NUL-terminated strings if you miss putting them all inside quotes :)
