Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83C1BEA1F
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 23:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgD2Vnf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 17:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2Vnf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 17:43:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5088CC03C1AE;
        Wed, 29 Apr 2020 14:43:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so3729153qkg.1;
        Wed, 29 Apr 2020 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wa4goGvORNKpxtYj+ALtCPme3G0z67iutTlHz68eUbY=;
        b=AJMedRCPiUCF7caPu6vsnawJy06bq6cxDxxXLnXXRtefHEfVaJTl2JNojwSg3spFG/
         0YcOst0P9qjUokFhBcuXlJBZioOLT9WkFnZFmM1NvcSPmde0jVR+unQ6N7aNTI8mCIo6
         vpe1JGhieppeVrfsmZK271yfdhevwuQ1dgvSrZQgJaPGMVZ/e3Zj+iC5/yL5TPCSdxY9
         MLbHrItgu9+E+yedJmgm+olVHLntsHgIEMlvd5H8c8XY76heuB8i4/diANOMH/7A+vBm
         /jFDuLCHAv6q9eQO4GMlAj9Db9blkMX/rXDRSimy89f2WJGevm200czjnOwHfemN4sg2
         y+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wa4goGvORNKpxtYj+ALtCPme3G0z67iutTlHz68eUbY=;
        b=H2tlHUIgwr8wtOv0bZYzjixxE7l2m5va3dJWpLnMvGnQcpXkZsPlRKexZFgZYQyw3h
         x+nG0EDN0ib46RRC1+IY9xFAYhXhZHYJJHrC+O3Lb+sojYqjlziNbp+G99oIC7UOuSc5
         EkxH4fAJdzi7WldCcAwZfprwb/Vh8D/wwaM6A/wj0iWlH21J228RbH4uoGqeK8LemPob
         AFK3e8akkbHbHx5pCLIeYLNwwwnszrWkLLHETMBTcDpFag9B/q7l04EeEr+Z1vnU6mnW
         8s7Sfsh02u8Kj1NfyK1l5ulB2qZ8Ob+Hk2QhZ/IU4IkR0DkBUKbVdT6NQLQv694UfBP6
         gGHg==
X-Gm-Message-State: AGi0PuaH2BQru4Tqd8T2nVHy9BplWAIuHqtHu1W3Bx7BoZrf3z0SlK0o
        Nb8Wjd1OUD2OrPb01VihvAA=
X-Google-Smtp-Source: APiQypJcBVrMfq1wK1lF7RPKKCrrgPz+vDyXnMD1mPuewHZHNZo6FwaPD8YtQ22MuuKC6jzlr7IL3w==
X-Received: by 2002:a37:602:: with SMTP id 2mr519873qkg.255.1588196614530;
        Wed, 29 Apr 2020 14:43:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b68sm305288qkc.132.2020.04.29.14.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:43:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 29 Apr 2020 17:43:32 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] efi/x86: Use pr_efi_err for error messages
Message-ID: <20200429214332.GC1621173@rani.riverdale.lan>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
 <20200429174120.1497212-5-nivedita@alum.mit.edu>
 <f74fe4ad56c0471f863ce550869391c8811f9893.camel@perches.com>
 <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXGn70BmapKe=6sA17gMCcWRLCebQJFnyObwRbAefOcEng@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 29, 2020 at 08:49:21PM +0200, Ard Biesheuvel wrote:
> On Wed, 29 Apr 2020 at 20:47, Joe Perches <joe@perches.com> wrote:
> >
> > On Wed, 2020-04-29 at 13:41 -0400, Arvind Sankar wrote:
> > > Use pr_efi_err instead of bare efi_printk for error messages.
> >
> > Perhaps it'd be better to rename pr_efi_err to eri_err
> > to it's clearer it's a typical efi_ logging function.
> >
> > $ git grep -w --name-only pr_efi_err | \
> >   xargs sed -i 's/\bpr_efi_err\b/efi_err/g'
> >
> 
> Yeah, pr_efi_err() is probably not the best name

Should I rename pr_efi/pr_efi_err to, say, efi_pr_info/efi_pr_error?
