Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9913C9CB
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAOQl4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:41:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42373 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOQl4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:41:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so8766118pfz.9;
        Wed, 15 Jan 2020 08:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YP7CTNz6a3dCy8zDMExrzBPIrn10Z5e0Mt+2YEGXARo=;
        b=eBiwTYRssRB+1iDkTlcP9SMuJxtsIh20QBhd5432ccnH2vRB02CIURRjggZb448yOp
         41iybHiaeJEvGPi1zaozRncbWrWSbsY+D5HV4gQk0fqwY8QEykghAoSu+C2y2swsywz1
         4MNY242lAJpvxBIPK0cUVWPgEjN6DyLPgv3d2C11VDnvLdJwZ2OpEc9ideNX4Snbu7Je
         sCijRJk5QxqzsNmZ2K+al/z+yZsiAyafr6PdyNiAcWY+mFPx67/1LmfZ5cexmN45Zywh
         aSnuySi3szcfxbyiuSNEJ6TyB19WoO/Oq2vInRpdkQt3XJjrUGAdRaSGmaK0sAIDMjig
         CK6Q==
X-Gm-Message-State: APjAAAVjMIxTB8TiOY/NjDUzA/9KUxgudiRrdWzPxp/2aS5USOzLk/rF
        LjgiEcDyp6letct/YPEs8Uw=
X-Google-Smtp-Source: APXvYqxK8dMz2VMI8rXkr5KWiQx0VbRzpUJsbzljQrzDmqj8pcR/I7pAnlYdj654L9Lu5WAwdBlMcA==
X-Received: by 2002:a63:4b49:: with SMTP id k9mr33873427pgl.269.1579106515626;
        Wed, 15 Jan 2020 08:41:55 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r8sm287748pjo.22.2020.01.15.08.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:41:54 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 02E6840244; Wed, 15 Jan 2020 16:41:54 +0000 (UTC)
Date:   Wed, 15 Jan 2020 16:41:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Subject: Re: [PATCH v12 06/10] selftests: firmware: Add
 firmware_request_platform tests
Message-ID: <20200115164153.GG11244@42.do-not-panic.com>
References: <20200115163554.101315-1-hdegoede@redhat.com>
 <20200115163554.101315-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115163554.101315-7-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 15, 2020 at 05:35:50PM +0100, Hans de Goede wrote:
> Add tests cases for checking the new firmware_request_platform api.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
