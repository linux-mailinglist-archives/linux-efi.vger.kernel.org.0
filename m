Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9474F1DB8BA
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgETPx5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgETPx4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 11:53:56 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0739C061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 08:53:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 142so4035928qkl.6
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UJld030alOVh64kzKTSwXpgdo9+76xbjSjpepXvKCx8=;
        b=QrZgLoHdn7j5TBCxEduScQpiQWFi6TarSDb7M66eT9GuEVG2ScZ+Lu5CgL/b8ZiSPP
         Ai6Asdve5P4hzXXP9qo7ieCfyJzsDpQChABYB6WW2j3HXeOclYItPWcdUMHVQdYJ303/
         gb4nWkWzZ6x/wClfFQjonH8xj6+fNYqagKHp09hZHiBzxKdtFYkN+2Neg97Z38waoZx5
         saGZ4e1BUO9gXhEt4sHaTe8ast9oU7EyFYneD1NwZak91PFKVJkrx9oLsXpGxZK/zOMT
         INf/rJC2+CYcDA5rkU4au9GpVUOMHyODZich+JmRvXrpFPDE5R4/WyKX4OHhryps3WAY
         Q5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UJld030alOVh64kzKTSwXpgdo9+76xbjSjpepXvKCx8=;
        b=sL958HqL5DqtJgJGyTZxveZfFWhyKojJcUYda4/yADYn2OJCc/r5WFvf5NUfFkRnIu
         gT4WH+89dtDOWMyiy6hEIaW13xurP4Pc+iAjA1B5Xb2Ar7XHY8/InS92hDOa3gJn3MaQ
         Lz3ONyER+lFArukfg3oPEDfqh1uFX7a2ZIC0Ehaz09mKNCPBxIK/BX36KnXZeaVeJDpZ
         QOqF0StAomMeiLGyGip5fgMK3SSRCt5jm7jQxDXM7gzl2oKgcrDu6gQ47X3+tYdkJ4uk
         6HRL9c77f1OOds4loS00p7Uq0B9dVVm5uVCsLW6lSNpayr1+lYSXywtYw4lQc1UpAwJi
         jbbA==
X-Gm-Message-State: AOAM531y5YU3fw0PFkaUvfC8FDjr01udHt4+m7FNWesSHE59TqbODVQ9
        ZrsazZdPj+uqEunPN7y/CaE=
X-Google-Smtp-Source: ABdhPJx5DigIwsQ9oi5RkOWVGuxwxGukNavtPtOUBABKo5YTP7+GEj/hDIVJPQjPWniZ8drRpb1qxA==
X-Received: by 2002:a37:a2ca:: with SMTP id l193mr4960197qke.23.1589990034968;
        Wed, 20 May 2020 08:53:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t130sm2550073qka.14.2020.05.20.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:53:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 20 May 2020 11:53:52 -0400
To:     kbuild test robot <lkp@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [efi:next 22/40] ld.lld: warning:
 vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32
 against symbol ''
Message-ID: <20200520155352.GB3184088@rani.riverdale.lan>
References: <202005201012.pqmB8hA5%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202005201012.pqmB8hA5%lkp@intel.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 10:28:13AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> head:   e5fbadd1179cdadeaa44d71a9ec068c5bc100524
> commit: ce5e3f909fc0ed67e58367b9c56a54c20a51080b [22/40] efi/printf: Add 64-bit and 8-bit integer support
> config: x86_64-defconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout ce5e3f909fc0ed67e58367b9c56a54c20a51080b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0): has non-ABS relocation R_X86_64_PC32 against symbol ''
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Clang folk, is anything actually wrong here? This seems to result from
use of unreachable() annotation, which generates these
.discard.unreachable sections apparently to help objtool.


