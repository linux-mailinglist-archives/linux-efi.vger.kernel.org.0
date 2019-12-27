Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7B12B49C
	for <lists+linux-efi@lfdr.de>; Fri, 27 Dec 2019 13:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfL0Mwo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Dec 2019 07:52:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37031 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0Mwn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Dec 2019 07:52:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so21478311qky.4
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 04:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ZPXGiWphnY39j9Ct35n4JEvkrQS5IkP4XtRC+gSGac=;
        b=p/yA1xzpGrb/JG9dN/JFAOp8EtjqdyTJ6Fp8tqybbe4ctwzlJh3Aakr2/BmaXB61r1
         vD2ktXO0CQ2qRerhv8sphB8g+8KTgGaApzINLeavE9E3BlNh6zFUXJpYm4b9TPFkuXVu
         7NKqZc01DS18+UvGqgnBmDL7GdlMxEqp0Uei5Ailb1Wk4HF1EVXLwzs9WQcq/LKFVPFk
         DpkzULmcKmfS02yVuwGHQDhnG+jBgiGmK7cVyJdE3YhtuIZFYUw1BomMe0KcKoizT8t6
         IYEi0dU7ljdapaZNEYM9wI0i8VWf1l3YR9BaGvUT7SiVkHCu5KRfabLtWuXIW2tHsNWa
         LJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ZPXGiWphnY39j9Ct35n4JEvkrQS5IkP4XtRC+gSGac=;
        b=mDqJjMHobItugaJqLszROW00RQ3sGIo6oxqTMGdU8fXaXKSldjiBDLSZdo39dZ488u
         Ix+cAZVX1T+0jLd0fYm6iP4lrWTfoMLz1lCsDVHj/Z9bVrnfVlW7k2+iidKCIpHWkIFu
         iTKLLlKIIPfR0kDa9EpzJrzbCY0u8oqFVLvyUfKWZI+P9Ik2PUSDcjX8CBPuNBKKrQkz
         tMqSfPLKbdk8Pnl6XZKInpXO9nh6wvD0ztw7NfVctS+TIrDMv9uzlSWCKBzsOVQDZsSu
         BDS9PQTG5Rd3F9nyesKBeNAcT6/GJImsYdePF0wGahp6O5VKtpzOV59XxqeBr0h1Vk7p
         nOWw==
X-Gm-Message-State: APjAAAXCT9c6X8LNrXeEwUZzuQzTVpm4RAR2+fCpp+Mu7oKbHi6hoS/a
        59eJctFcsV4xXiWn4yF8as8=
X-Google-Smtp-Source: APXvYqyw7WMJGnP8CpjH4wZwLgzaEbWuf3xiogYTEAbvNQrXTcDu/mfVY/aQbdWNAfHabwNOXweF8g==
X-Received: by 2002:a37:e408:: with SMTP id y8mr42848254qkf.39.1577451162672;
        Fri, 27 Dec 2019 04:52:42 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r80sm9717683qke.134.2019.12.27.04.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 04:52:42 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 27 Dec 2019 07:52:40 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/3] efi/x86: simplify mixed mode call wrapper
Message-ID: <20191227125240.GA523777@rani.riverdale.lan>
References: <20191226151407.29716-1-ardb@kernel.org>
 <20191226151407.29716-4-ardb@kernel.org>
 <20191227043424.GA435594@rani.riverdale.lan>
 <CAKv+Gu_xDqN-AyB=tp-JZWn6Ksv3cvpkgDhPL2NfiWTMEQNo1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_xDqN-AyB=tp-JZWn6Ksv3cvpkgDhPL2NfiWTMEQNo1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 27, 2019 at 09:05:46AM +0100, Ard Biesheuvel wrote:
> 
> In theory, yes. But all this code does is move the top bit from bit 31
> to 63, which should be fine to convert any return code you may receive
> from a runtime service.
> 

Oh sorry, I misread the table in the spec and thought the warnings have
high nibble set to 0x1.
