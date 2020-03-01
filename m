Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A6174EAF
	for <lists+linux-efi@lfdr.de>; Sun,  1 Mar 2020 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCARWv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 12:22:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34596 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCARWv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 12:22:51 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so3783498qvf.1
        for <linux-efi@vger.kernel.org>; Sun, 01 Mar 2020 09:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kQo7rGK2mPzf3YsSqjQhLJ5wdMbDo4Y4Q1lQsj6mISM=;
        b=e1hlSLQ+zVkhj98KwCBSceFWBtHnslWRFy1JnQ2YESsrTUlLrP5UGlG5zm7CN/Mod/
         GBMhmy/ULjrThfULRDpMlaqVyWivoWJ0nPQP/u0mU9tF5HUzggCFMxki+PgBgFHCtFZ6
         qdxbzUzu1hjWr3plQ8+9qIVzojWM3hxhNFqNISyu4/BwfG508DZR6HWQD0F5adpRT1Fw
         u2TahVF1kihYOiJx1K1XPJA5lL7/Kr27ZkYV+ZE3bu0GTW/B3j9Yj75ftktqCLVaECoM
         OKDApIa19t4dg0nspuMiNXFI0VPLYKQdcbzrMWowFZMicQUY+N3pLURUoObiyjlNEmxK
         ONzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQo7rGK2mPzf3YsSqjQhLJ5wdMbDo4Y4Q1lQsj6mISM=;
        b=PqFDZvQui/m8yA/oLB+eWMrqu09LWzpvRCIaA2bp2/fcKfwW+Frr9FFYrmAo/pl+5Q
         8rigLbRiVoDwGVHZiQT8cc3LNuIxwmjTQ6k83vJBYFYN76x4z6Bj0K7nh2e2GAQvyjgX
         VAjyHuVNmpA2XsMajEZmLRk26a5R3myVTIp0Eq/2PcPakqzrokj+lq+m64eJSK8rkidA
         Ck1PsBPOUAKvmqk84jGLc/I8HY60LrUnPHgIJEP0vY0KXqAnqKdkZ1xWqj9tLXI36yL0
         eYcGDdPVXTadnHJMKP7VXADtn2CR82fZJhA7re4esHRKGk+WI+NObT2nZYWz5O/G6X5r
         pvkA==
X-Gm-Message-State: APjAAAWYMDpKEIEcdC+RYlkt54BPd0GAoC6YHs21iKNRUYzMtw9CZYbt
        C5x0VYfhaImoicMmWOAk9RCl6pRzcf0=
X-Google-Smtp-Source: APXvYqzJH8E+I2SpcEmqQJ/90xnEk348JcNgMa72koRYuicPjZ5vQXxeV5Z8Rl95ALunLN9Z4DXzGw==
X-Received: by 2002:ad4:518d:: with SMTP id b13mr11714748qvp.141.1583083370862;
        Sun, 01 Mar 2020 09:22:50 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 194sm6731374qkk.117.2020.03.01.09.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 09:22:50 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 1 Mar 2020 12:22:49 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        hdegoede@redhat.com, x86@kernel.org
Subject: Re: [PATCH v3 0/6] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200301172248.GA1851857@rani.riverdale.lan>
References: <20200222155519.23550-1-ardb@kernel.org>
 <20200301171509.GA1845222@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200301171509.GA1845222@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Mar 01, 2020 at 12:15:10PM -0500, Arvind Sankar wrote:
> What I'm doing is creating an x86-64 defconfig based on tip:efi/core,
> and then running it via
> 
> $ qemu-system-x86_64 -cpu Haswell -pflash qemu/OVMF_64.fd \
                                                 ^^^^^^^
That OVMF_64.fd is incorrect copy/paste from a different run, the panic
case is using OVMF-mixed-mode-compat-section.fd.
>   -drive file=fat:rw:qemu/boot -nographic -m 3072
