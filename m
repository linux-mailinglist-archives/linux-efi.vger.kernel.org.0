Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169AA1AD025
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgDPTHj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbgDPTHi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Apr 2020 15:07:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0030C061A0C
        for <linux-efi@vger.kernel.org>; Thu, 16 Apr 2020 12:07:37 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id w24so17368050qts.11
        for <linux-efi@vger.kernel.org>; Thu, 16 Apr 2020 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G3QAK3EQG+LMpKA8lW8S8JKPYZZgk3isr2t8e3jJe7o=;
        b=sDeQ4B6yqpF6g27vOdSY0EARXE973+wgAk5rYMSUghlxonGEfK6b5O4b5z8jlo0s06
         hsCtlklBRbY+Tufp9q32iKkyVUxzR9XfykVt9ZqEakhhEevQERSzp+ZhBhfS3qpLbt0a
         w5igdxwlsBPFTyOS4bCG3Dt7brh6PovWbA03+cBfSDFzt0BbOZK9cFQ2vlxLAjw1yPOJ
         kryyFnVqvbBoMTD3knvUKGx/n23VT7BYshYX56q3zeK2OwoNSutwxWCbeV5y4DOIoXPb
         kI64j0wnwEJZ6sTvOyZsk5r521BbDgCHDJj0bdliFu4zjGmMVms5sN96FTLtTSeET96I
         +nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=G3QAK3EQG+LMpKA8lW8S8JKPYZZgk3isr2t8e3jJe7o=;
        b=iY42TUoVllxPgTh5WAvN1imK0hb9O/57U2FKLf9WRhIgfxzplvOzQd/sWJdvFE/eiU
         WQ+MWOl0Df+GaBj3FnQWF9sp6kLyqYkRWtcAc7TUZkfaHqkIxEn4FzR8lAo7b/p2kguy
         Z2uXzBFZSLQnDCowG/8AaMXlJGraq7DAZT0/L8cDbRAK3nUgkUhct4HTr4dIIQY3cGlu
         Mo1vynMf76CF6yUwYOFasFlXi/1HwGodriU9f2YJc+QwBFESzY9vBQh3xvFpemul+/iY
         KwBXng3khDf9Nlyi6qmnXfjzMPqiCCWWVpA+ogvKBe0FWjS3/keZw5St612UZN9QI8ap
         aH/Q==
X-Gm-Message-State: AGi0Puas5mU+ZkWdgx6aj+XR+9y4xl5XfkhLXvMIjH9218KepCZSea6p
        mr+vmd2/QT5B8AesTZulSETHo3wj
X-Google-Smtp-Source: APiQypIin8J2fq8nm9mEptszFiz2iUJYCZ/jOD8m0974qRtp+XAf42QqjXNtm6055a4BWe6G1lgqVg==
X-Received: by 2002:ac8:4cce:: with SMTP id l14mr11021470qtv.31.1587064056659;
        Thu, 16 Apr 2020 12:07:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w42sm13416532qtj.63.2020.04.16.12.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 12:07:35 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 16 Apr 2020 15:07:34 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, nivedita@alum.mit.edu
Subject: Re: [PATCH 1/2] efi/libstub: drop __pure getter for efi_system_table
Message-ID: <20200416190734.GA3540850@rani.riverdale.lan>
References: <20200416164831.11724-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416164831.11724-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 16, 2020 at 06:48:30PM +0200, Ard Biesheuvel wrote:
> The practice of using __pure getter functions to access global
> variables in the EFI stub dates back to the time when we had to
> carefully prevent GOT entries from being emitted, because we
> could not rely on the toolchain to do this for us.
> 
> Today, we use the hidden visibility pragma for all EFI stub source
> files, which now all live in the same subdirectory, and we apply a
> sanity check on the objects, so we can get rid of these getter
> functions and simply refer to global data objects directly.
> 
> Start with efi_system_table(), and convert it into a global variable.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Could turn efi_is_64bit() into an inline function as well?
