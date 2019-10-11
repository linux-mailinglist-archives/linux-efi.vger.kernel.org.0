Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7BD42E7
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfJKOba (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 10:31:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfJKOb3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 11 Oct 2019 10:31:29 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B49B79705
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 14:31:29 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id m2so5865861eds.12
        for <linux-efi@vger.kernel.org>; Fri, 11 Oct 2019 07:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7jeAeBI7smw0DkvEKb+yEiLD6lnpDm/GMM/0BPj+Sg=;
        b=svTMcvHFZzfsuJeI0tcngfzXstq81QVnDtyXrmtY0W3U617Nz750gqGq62dmLAzuuN
         sQ6UEUE57yYU3LoWbRjaTPZKIOxZ/Aba5kvo/bZmRPFr7Hfo1gr9uEXAwcjtvxw8Dt9j
         it/8VrvdzY+Lcuy4va/IG6+LYfVe++VYugvirR9VaBOkn9UyLo5DboHBbJZpsFN1CQ7a
         lbYFaW3G1ncBYnOPoq0oP2OqJR676u9OIkl+8DZNglaI4Hp3QxnApTZvItzkhkm6TFQU
         P0tNT27qRiEvfnLGXFaP3IsgyvlM/4Y0M60st3/E4D4FLSuXBAQ2pd6IIykhjSeoYONR
         NmnQ==
X-Gm-Message-State: APjAAAWDAV/60cIVpvm/HD/tqdyYgl5+G6w20yAfS21cEOHVkC9AEi7n
        UVRQt17XFY3hAaaBuAXq+r25rRTSSjxDP2sGAVLQCRPegia/f7Y7ksrrtSPcDwLKHbt6Lku/CXX
        iYcFIQwZhYAiIwbKK/VPr
X-Received: by 2002:a17:906:2319:: with SMTP id l25mr14159771eja.309.1570804288242;
        Fri, 11 Oct 2019 07:31:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoRZoAH1NMErSVdJalwF7TdgOzUSOFWLs4mQa22TgCcFbTlVZIC719vTCBSczupc1e7bsjHQ==
X-Received: by 2002:a17:906:2319:: with SMTP id l25mr14159752eja.309.1570804288071;
        Fri, 11 Oct 2019 07:31:28 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id s22sm1224314eja.91.2019.10.11.07.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 07:31:27 -0700 (PDT)
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
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
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191011141036.GK16384@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
Date:   Fri, 11 Oct 2019 16:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011141036.GK16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 10/11/19 4:10 PM, Luis Chamberlain wrote:
> Hey Hans, thanks for staying on top of this and follow up! For some
> reason the universe conspired against your first and last patch ([1/8],
> [8/8]), and I never got them. Could you bounce these or resend in case
> others confirm they also didn't get it?

I have received feedback from others on the first patch, so at least
that one has reached others. I've bounced patches 1 and 8 to you.

> While at it, can you Cc scott.branden@broadcom.com in further
> communications about this patchset, he's interest in some other changes
> we'll need to coordinate if we get to have some other development in
> line for the next merge window.

Will do.

Regards,

Hans
