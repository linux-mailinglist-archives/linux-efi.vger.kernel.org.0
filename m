Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209041933A3
	for <lists+linux-efi@lfdr.de>; Wed, 25 Mar 2020 23:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYWNS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 Mar 2020 18:13:18 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42744 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWNS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 Mar 2020 18:13:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id t9so3660389qto.9;
        Wed, 25 Mar 2020 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kPUS/Aysk3tY6XivwpkoTqisyDuIuo8Gofrkf6ppxIs=;
        b=dBbIKbIzungrAOXSqRsPOGmOljJQP3fqPF2goF6c0O7M08MjlIviBG3/Kwk/RguoIc
         XYSAVLs6uvaiFzXVhIGTpM4JV4RwVWQxDS/U66UjoOEWH6ViUMifz74BRlKWcCEATuBu
         4IQnUybUJSfnKvtdQ2rx3L7pGAsYSEVWM71D9e7ESbu2uld0B9Gga/tYFwYo3ms5LjYl
         YPfKjbfYhx9qJGukJB+uZJwdwmX2TGuVfL1sjw/CpwpWGfoJlw7FwME32Cts0YfiskoS
         6qg7usgmUJhHTKWogB8SEfCZ6jC1RXEZNPrPD0UJ7WKynvhO4sHg20R1bQqGAclS2QJQ
         M9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kPUS/Aysk3tY6XivwpkoTqisyDuIuo8Gofrkf6ppxIs=;
        b=Orxtvqj2pcmd+dhE+XBxDaOPjiBxpy05RUm9Y+axw1+3k3L2ttkvWIHdE1Fx4leMME
         EkF/MUOwT81fW8Yv+KJVYS5iJhXdzvIM/hGIGRIKKICvaBV7MCeVfktXAvA+KRr9xsjR
         CdQMQq4B679+GC/ZwUlc73HGqTFBi/5MosIVuBqad0rXLfWH42D5msLVsLOBh2eV4Rb4
         DIj7vHCcO19P39wcDFD79SPztZDERf2gB0zMmWc3B/qCzWZsmIZTUgY4NR9XAgcBhN/Z
         n+uayTHyEry+5+6L9ij28q3xKtwFkc+QM+LueV75LMAUwKYUzIuk3u61JnAA+QXICzsZ
         Lupg==
X-Gm-Message-State: ANhLgQ0NojtzC/lyewHFlzojNQWndwiH9MwFCJjZ9eVpnKbEYvxBEljA
        bDLCUgku3U0wKg5W5OXLS2w=
X-Google-Smtp-Source: ADFU+vvjrJQiWKrMoQjR9d9oQ6UUHt+nZcS7+oXfkgFokukX+VzGlQZHZQeiDRVmqgI2+VRjybKI3Q==
X-Received: by 2002:ac8:4e4f:: with SMTP id e15mr4889814qtw.212.1585174397027;
        Wed, 25 Mar 2020 15:13:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t123sm122843qkc.81.2020.03.25.15.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:13:16 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 25 Mar 2020 18:13:15 -0400
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
Message-ID: <20200325221315.GB290267@rani.riverdale.lan>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
 <20200320020028.1936003-1-nivedita@alum.mit.edu>
 <dcb1bfb1-9663-f149-a29c-87e5a6c6c2f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcb1bfb1-9663-f149-a29c-87e5a6c6c2f0@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 25, 2020 at 05:50:19PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/20/20 3:00 AM, Arvind Sankar wrote:
> > This series is against tip:efi/core.
> > 
> > Patches 1-9 are small cleanups and refactoring of the code in
> > libstub/gop.c.
> > 
> > The rest of the patches add the ability to use a command-line option to
> > switch the gop's display mode.
> > 
> > The options supported are:
> > video=efifb:mode=n
> >          Choose a specific mode number
> > video=efifb:<xres>x<yres>[-(rgb|bgr|<bpp>)]
> >          Specify mode by resolution and optionally color depth
> > video=efifb:auto
> >          Let the EFI stub choose the highest resolution mode available.
> > 
> > The mode-setting additions increase code size of gop.o by about 3k on
> > x86-64 with EFI_MIXED enabled.
> 
> Thank you for adding me to the Cc. I will add these to my personal
> tree, which I test semi-regular on various hardware.
> 
> I've only looked at patches 10 - 14 and a quick glance these look
> good to me.
> 
> I was worried that you would maybe always enumerate the modes or
> some such, but I see that you have structured things in such a way
> that if the new kernel cmdline options are not used no extra EFI
> calls are made, which make me very happy!
> 
> This way we do not need to worry about this patch-set tripping up
> buggy firmware (which is quite likely to be out there somewhere)
> by making new, previously unused, EFI calls.
> 

Yep. Also, if the option is specified, it does enumerate the modes, but
if the currently set mode matches what the cmdline option wants, it
won't reset the mode, so it shouldn't interfere with seamless boot as
long as the mode doesn't have to be changed.
