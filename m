Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33095D426C
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfJKOKj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 10:10:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfJKOKj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 10:10:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so6149202pfg.13;
        Fri, 11 Oct 2019 07:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mnGbwefIqKastaz5advYFrncKnKjfcU7jtCva8kk2g=;
        b=nqPJcD8xo+8r8hakIm9r1b4zrovgP79c9J4rDTuUEWdYZOc6qhxediZSVCm6FSUxca
         EXjXQsIIpUDh8Sb8nZpKGcCNAwLhOTXgF7DYo4w4nzs+6jUIhMm1pPh8zQCZSm424t4R
         1zEYG5sY/HYzc3LKNolgx1FS5VCPg96KFFL2H2OYZYfS3+JE9iE4cnsOj2uMV5cm6Pos
         A+VwyNsDA3/OUcdHX8+AuJDX5dx3/1Lq2z35jQC0nzyWaMXnxgN4HHqYQX5+ikBf28VQ
         TnkLzuZD6kuGGUrZr6NWcuu5jrrkGn0tMesR5PuwUIqzEbZ4Mt6JxN+Pmc3PZ1HQ04jH
         vexQ==
X-Gm-Message-State: APjAAAX2QuPhxIN9IVmOwVz7SNtkuuDl+dH5o57tcNq5OvDFlQM6M6gv
        2m+PVLQrFGP8GIyO5YH05Jw21YQr+Zk=
X-Google-Smtp-Source: APXvYqwulWIrQ2LtNREeNBuPTIuNGsJh5aG7oVSCrF2HLnZ4G+Es9m/PbNEpUdA1QGMF+yma+Hgm8w==
X-Received: by 2002:a65:6910:: with SMTP id s16mr17061184pgq.284.1570803038188;
        Fri, 11 Oct 2019 07:10:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h68sm12740598pfb.149.2019.10.11.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:10:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 47128403EA; Fri, 11 Oct 2019 14:10:36 +0000 (UTC)
Date:   Fri, 11 Oct 2019 14:10:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
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
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
Message-ID: <20191011141036.GK16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hey Hans, thanks for staying on top of this and follow up! For some
reason the universe conspired against your first and last patch ([1/8],
[8/8]), and I never got them. Could you bounce these or resend in case
others confirm they also didn't get it?

While at it, can you Cc scott.branden@broadcom.com in further
communications about this patchset, he's interest in some other changes
we'll need to coordinate if we get to have some other development in
line for the next merge window.

  Luis
