Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE31CF7B8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 13:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfJHLFU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 07:05:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHLFU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Oct 2019 07:05:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so18902678wrt.2;
        Tue, 08 Oct 2019 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J92IWr2VJrY20cgBoCqlCjKaHqq8B9mSOS3pdXzLByg=;
        b=GKdJOsXaS7oy+vYxeRfBem2DpcZoE6xluLj7B3VZTd++gIRdIJHAcBwflVR9iSzhQz
         4agGD+SXLAQpDauw+zsmyJmc6rRgnr9DExjP2T7luIcMToCWeoU58bsgQvtMzaxWkRY4
         Yh7pen97p38z77CKnPJnh2YPRXmecSZDn5dNy5gVegEQUeHiEj3ILmYDYCH6lP0lPMQV
         Uxxiy9i6L7xJ5CBeziZ8AkQTnSX7D72++VNm0FsKLTLNQggABvslqBOxcNTTzly3Mcwm
         tQjQvDNBWsHZxyvcN5Git1HIfvbXLuuPnSinhKmCgnUGTiymalAPRNBzrtya3eV4Ko/d
         Z0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J92IWr2VJrY20cgBoCqlCjKaHqq8B9mSOS3pdXzLByg=;
        b=eRoiECqRaY3kYbXNEVkLVYA04ewDU7GuVsekHS0xalFyvae5nfNIws1ybPtN34IDSA
         mAayZ81e//su919o5JjDuurfOfaCRz+aBKddvJGpnr97QLo6aLsFuJRkP8ExOHWSeOWq
         kCyu44u1CbFpL5REJ7hOgS9+Zd4r9CKQQtvqNRwSIPc0mHLD3bnbsgMCa6wUGr8ZJ3Uz
         fIUYgjWZ/fKm33gwBR56iqmm/DPvQgv3EnOdgkDuQ1cCzc7qeCRbzFO27ScP8JNoITCS
         P+KPVlc8jICTGwe/kRFomRLu1ERS8cURWKOY26mAw0jNV0zQwgm9sSh/yrmp0lSUda7+
         DqNw==
X-Gm-Message-State: APjAAAWm5M3/MTiph7ZBQH9FYYwKsHxoNbsrgBrYMypyWn4lthLYrDxt
        r7tnZEV4Ipcp6xQ1VW9/puQ=
X-Google-Smtp-Source: APXvYqw0NawJTWZiuMShXAIsYRAaf5X0VI1pfia9S89FIVn+31OYEpLhXWLX+LczhmPApHBFq4cRVw==
X-Received: by 2002:a5d:4102:: with SMTP id l2mr27721246wrp.348.1570532715866;
        Tue, 08 Oct 2019 04:05:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e15sm21826909wrt.94.2019.10.08.04.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 04:05:15 -0700 (PDT)
Date:   Tue, 8 Oct 2019 13:05:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
Message-ID: <20191008110512.GA116541@gmail.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191007141956.GA25347@gmail.com>
 <c7f1678f-ff03-1c3a-02e3-a68025b87969@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f1678f-ff03-1c3a-02e3-a68025b87969@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> > So I was looking for a high level 0/ boilerplate description of this
> > series, to explain what "EFI embedded fw" is, what problems it solves and
> > how it helps the kernel in general - and found this in 2/8:
> 
> Sorry you had to dig into the individual patch changelogs for that
> I sorta assumed that everyone involved would still vaguely remember
> what this series is about.

Wasn't *that* hard to do and I intended to read the patches anyway. ;-)

Thanks for the explanation and the answers, this all looks good to me in 
principle and in implementation as well.

Thanks,

	Ingo
