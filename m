Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9358A176DDE
	for <lists+linux-efi@lfdr.de>; Tue,  3 Mar 2020 05:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCCEOq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Mar 2020 23:14:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46766 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgCCEOp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Mar 2020 23:14:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id u124so2079062qkh.13;
        Mon, 02 Mar 2020 20:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e/yk7+ePR4UtnpfkQ11p/1R+rxFd28+s/3MR8pBHbkM=;
        b=NJZUDSvZr2Hke22ZDjqTxy7uY06oaXg+hUkBLtFjEcOrTthrFpTnaTNkfB1r3m/UPV
         bYJG44P9dmYiEwdBtAiAA6bBZbv6GL2brr45BREnFlIBtKEQi5cn1wmCoNsVfSQVrVpy
         iHb1baVDGSh7NClRWvPeeg4YNvjZgOBr5BbSgP50ybspPc3pPVPCkvE85V7JEr1izcPR
         m2N5RCH16/8gWeS6q4NwKYjqAScKGmIToI9MHsewpAHaMG3yoohCteG5Bo6rVH52zg7a
         BGFOi058cCW2syIDkNMpw31OHbTCTXsQovOOrjvlysm7eaNgyJ3qEA/cAo92ruIK209e
         64lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e/yk7+ePR4UtnpfkQ11p/1R+rxFd28+s/3MR8pBHbkM=;
        b=BPqrNmUymzsU9/QbyY63vwLjliD/MfLFDFxsaLJH3RmNosGEoZ/frp5XHlI55ybQ6E
         RMoc1omMg48vjOIMGXvOKDgQe6G+o3Wj/+u64cTN1AB7P5CEfCcQfkXgKOJ6muGG4P5h
         ct7prSh+A9KyxdGKu2hWYi82YRPkJdFvycYQ0oGZkyH03S7BWmOmwPVFsStws5yU4En6
         ilcVhNX/UvLa0CQwX0t1EeMKOTiFj1161xOsXLWjiGeHlq/FPwPzq7ZcSgpyxio5qnv0
         rw3Ddd4dYtLkVqsNKqxZdmBlf9PPqkP74+Deb9EtT8U1LAQR+9r20acdC1ncjgcw0IUu
         3hgA==
X-Gm-Message-State: ANhLgQ0ioFhZcLin45p1Jyj7tmh6/dgYFqjkftmwyv6CI1YH4hpBeVdT
        ePWZkx/xZzrCR91hGso+5yZHdlWjFCo=
X-Google-Smtp-Source: ADFU+vstdfZgsFwwnQ843hMIFfCj5PLqChP+Jc8jZZFxIyeRO7s2iu23cWxTQ4nq1CrWYMZaW57GFA==
X-Received: by 2002:a37:7182:: with SMTP id m124mr2409544qkc.477.1583208884632;
        Mon, 02 Mar 2020 20:14:44 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l16sm7153873qke.68.2020.03.02.20.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:14:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 2 Mar 2020 23:14:42 -0500
To:     Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] efi/x86: Remove extra headroom for setup block
Message-ID: <20200303041442.GA3518342@rani.riverdale.lan>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
 <20200301230537.2247550-5-nivedita@alum.mit.edu>
 <db83f5a1-b827-2a31-0ca9-a04df8257324@nextfour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db83f5a1-b827-2a31-0ca9-a04df8257324@nextfour.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 02, 2020 at 04:21:30AM +0000, Mika Penttilä wrote:
> 
> 
> On 2.3.2020 1.05, Arvind Sankar wrote:
> > commit 223e3ee56f77 ("efi/x86: add headroom to decompressor BSS to
> > account for setup block") added headroom to the PE image to account for
> > the setup block, which wasn't used for the decompression buffer.
> >
> > Now that we decompress from the start of the image, this is no longer
> > required.
> >
> > Add a check to make sure that the head section of the compressed kernel
> > won't overwrite itself while relocating. This is only for
> > future-proofing as with current limits on the setup and the actual size
> > of the head section, this can never happen.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> To make clear, the kernel (head_32.s and head_64.s) still relocates
> itself to the end of the buffer and does in-place decompression. So this
> is just to make init sz smaller.
> 
> 

Not init_size itself, but it reduces the size allocated for the PE
image. Do you want me to update the comment to make that clearer?
