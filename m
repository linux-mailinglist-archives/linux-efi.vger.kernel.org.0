Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FBC12E853
	for <lists+linux-efi@lfdr.de>; Thu,  2 Jan 2020 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgABPvc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Jan 2020 10:51:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45942 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgABPvc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Jan 2020 10:51:32 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so31610986qkl.12
        for <linux-efi@vger.kernel.org>; Thu, 02 Jan 2020 07:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGpdYiifQJ/eEi8APsB4Nyw4430/s1y8cd2A8680zFU=;
        b=lP0DvvDqlcJ50lQCjw3mm80EsfwjBnP5SGMTi0bZB1gP7EOr1D4nhEBJijrRBTCi5Q
         8ZWcrZOeeV3Zt99hLnheAuX+Fe0CSrRAF0otZKx05UWC8xbWhImVbUXVSZZtEHHWTGTR
         kpeYreTkULyRd3bRym2JgEMFSF2aQe6DyLdm5OC1KTlDmAXdPFMN/skZiM0Yq03b0t8t
         2uu2fYapscUC4qxbp2WJGjHgubySCelj16cGZQ9lpGjxy+7RXnRpeN2p8arqcghK965l
         E/MpFzsEtECiXr/pIlAWppMcYR/OdwUGIMb53I02omdGW7OrYowmL6M9LzT62PKkA5JU
         v//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGpdYiifQJ/eEi8APsB4Nyw4430/s1y8cd2A8680zFU=;
        b=jnu16B0PxBDnnx8C5xdUecpAAmWLu8u0nRwyU9VSY2gDaeC1vPzvYGdzLUiMvjpaGG
         9+6djR35c0ikehxIL67BZGX8Uyhf7mSS+2famqgDMprq+cEMkayGBRyFAR6jQ1IoR9be
         VFqA77tdzlBQsP2NO4KxZTFxJ5bl6v/J1/HLx5NdaZ8Kl/kMjl9g/0B6yIqZU/gOTsw0
         JNoU84feiTwWMty73g+yc0bFJiv0Ng4DLOE6+mJuGT7L6qn2kzlmTlZ6F4h3DqicRIzc
         QuGaCwAi2tCexANnFodRfnwlCdoTHl99RumdvOzpUhR1n/GKuxHhCGwsTUzWWMQ5XHNA
         c7sw==
X-Gm-Message-State: APjAAAWxIy6yyaXQ7eSSPHkakSkO3tjKvDRnUy2S7FxP5o43LwrnhTFm
        11AWTXZ9WT0SU13rl75Vn/0=
X-Google-Smtp-Source: APXvYqzyHOXApqbo3vkhaDmGCfXAg1OanCLoXWkl/y/sy2qO6nkf4oQmAHcChojAUWkZrpJuFrwACQ==
X-Received: by 2002:a05:620a:15bb:: with SMTP id f27mr55263749qkk.137.1577980291671;
        Thu, 02 Jan 2020 07:51:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t1sm12992548qkt.129.2020.01.02.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 07:51:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 2 Jan 2020 10:51:29 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/21] efi/libstub/x86: drop __efi_early() export of
 efi_config struct
Message-ID: <20200102155129.GA668939@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-14-ardb@kernel.org>
 <20191231230436.GA78532@rani.riverdale.lan>
 <CAKv+Gu_6zKX9vtvJ9r_CMfufh9-0yOJikYH-Z2xtVcn5i8qwsw@mail.gmail.com>
 <20200101190844.GA208136@rani.riverdale.lan>
 <CAKv+Gu-XRgRXgiuDEe+DXdcEzOuUWG6fWMO_oa41f2Ugki5kCA@mail.gmail.com>
 <20200102140653.GA626673@rani.riverdale.lan>
 <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_Ca4nBORcy8JzUhE5svxZ9nZosuif7EtToYxqiBZfEQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 02, 2020 at 04:20:46PM +0100, Ard Biesheuvel wrote:
> 
> Yeah, good point.
> 
> I pushed as branch here;
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-libstub-attr-const
> 
> Could you please check if that fixes the issue for efi_is_64bit() ?

Haven't built it yet -- but how does this handle the GOT issues you
mentioned?
