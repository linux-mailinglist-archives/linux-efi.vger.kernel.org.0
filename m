Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51B91B85A3
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDYK07 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgDYK07 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Apr 2020 06:26:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08875C09B04A
        for <linux-efi@vger.kernel.org>; Sat, 25 Apr 2020 03:26:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so14571800wml.2
        for <linux-efi@vger.kernel.org>; Sat, 25 Apr 2020 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q7XxMj8XqUMmP/Zjv83N8e+6snMzzuvmgihACPBct28=;
        b=oveUBlGkL0yGuOJyrcsWvNh+fO2M3VsSHvCifeSMbNdhz9qRBxww2NyY98zLOKk0a1
         SW42l77JHWXxO8PMwn9zDgRlnM7uxTb3lM52647j9ffVp0+6AUo8RkLBDpaSqRjrVkM2
         twRFfBYjs/mIytHv4+/1BRB2k+m1JEZZhpg5IPCvMX9d6ktyjPu7nYM9d2GZoFJsOvkU
         dDPheWIL/Go/mIuPbuZXhjR9H3mnjp5XywqJFMMz/1wetw962q8k8XCa/Oqm/aV86Ebi
         UtSuowekM0efI9mqQ2lJf84rft09ad+keexudYj6gaQbKYifpyYc+6fRcZ2Dr9msivXM
         27nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q7XxMj8XqUMmP/Zjv83N8e+6snMzzuvmgihACPBct28=;
        b=hqLYHC6U9mlQwZ7r9Ls/gEzK3KzlxNuQreNCbPVB4emgml2nJUU2sJsKoJIqnIokcU
         xMV3wBL+5YjwSx43XIe8jXWeALd69Ts6zIlPF/tn/U9cYphakL39wQ27l8hKyz7maVG3
         LYf+499EJjdwVvHnOtt8Y+LzvsVDVKBqbYYMceOugC9GcZdyfN5zTK/Roj9dJ1U2sri6
         6ZSLkWcHxXP3QY//7YRClrxV3jSrKM5h4X3piwQkHQhnY4+AwSYhcpOFkUSAxw9FGhrI
         tvpqXvYW7isl1VpwHd13IF7ajcaUdoCWG5+4mEDZKJDbadIMtMv7tUCnn3f1MtiyAP2y
         rByA==
X-Gm-Message-State: AGi0PuZJ35O6FBaUbAe5cxHrcs7qZqEG1nWguyhOaCLkQUb0KK+ZHVxl
        T9umoQcGTT2OYSZhVDhB49k=
X-Google-Smtp-Source: APiQypJMLOsp7xoJ2p94rjsKDsFEoDc7Un9KDJbXMZIELnpvLuAyP9/BU4lPmGnLYOva799UVNZQ8w==
X-Received: by 2002:a7b:ce09:: with SMTP id m9mr14852887wmc.156.1587810417833;
        Sat, 25 Apr 2020 03:26:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k184sm6729887wmf.9.2020.04.25.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 03:26:57 -0700 (PDT)
Date:   Sat, 25 Apr 2020 12:26:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi/libstub: Re-enable command line initrd loading for
 x86
Message-ID: <20200425102655.GB12331@gmail.com>
References: <20200425102204.2622-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425102204.2622-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Commit
> 
>   cf6b83664895a5 ("efi/libstub: Make initrd file loader configurable")
> 
> inadvertently disabled support on x86 for loading an initrd passed via
> the initrd= option on the kernel command line.
> 
> Add X86 to the newly introduced Kconfig option's title and depends
> declarations, so it gets enabled by default, as before.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> 
> Ingo,
> 
> Mind taking this directly into tip/efi/core? Thanks.

Sure, done!

Thanks,

	Ingo
