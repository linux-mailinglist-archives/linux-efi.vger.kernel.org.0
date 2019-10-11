Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2628D4487
	for <lists+linux-efi@lfdr.de>; Fri, 11 Oct 2019 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfJKPi1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Oct 2019 11:38:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36453 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPi0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Oct 2019 11:38:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id j11so4643069plk.3;
        Fri, 11 Oct 2019 08:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=34jLy/imGQdWFtbRAmHbjncBF9hW7DDB6XsjLeKsQC4=;
        b=g6UsK9AsQg79c3wUOCOTtRnhwBm+MOS+XTCuLjFsc321I1TnrW4PNC6DwbBJm7UTI0
         D73zH6jJpSGPbyb7aS63BSUaw7+zcpZ6+04+aYX+aMgF8ep1HZX0pHAIbrhgZXpvW+NY
         LhPAfFMlMxriA3iV/gZ4z/VzVrLe9IlqaFmZiEkqx4MKHNlEuG5jv2p84kaoNr+qzwXx
         1hHWxcAsjSUnZBZssIq7eCTvGSFc2YB1NV1t9xa09O6y6rsybwI7MDYCMM1ChIIjGux6
         k4+/jep+b/AS6fdidWpfiWZbd9u/M9GScAjnMYRh6liSeMfzVhfMLbJRvSArBRXaevP2
         xiTw==
X-Gm-Message-State: APjAAAWaFI0MVobtg6SgBaJVnNcTN2LMu8JiAnf2b2IP/z2rVCShjBWN
        FsU1XOb2hsRPyeWWVZybb0A=
X-Google-Smtp-Source: APXvYqyhY7ooL/PoXLde16E2h3vfL39WPv8HqS8wX4TbBSrp9W1L7IydKIxBl2py8K1m/cLRrZ4cKw==
X-Received: by 2002:a17:902:7e4e:: with SMTP id a14mr15778620pln.68.1570808305879;
        Fri, 11 Oct 2019 08:38:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ev20sm8614400pjb.19.2019.10.11.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:38:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A888D403EA; Fri, 11 Oct 2019 15:38:23 +0000 (UTC)
Date:   Fri, 11 Oct 2019 15:38:23 +0000
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
Message-ID: <20191011153823.GS16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191011141036.GK16384@42.do-not-panic.com>
 <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fed4882-efa7-18d0-1ef6-9138fbdddfc4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 11, 2019 at 04:31:26PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/11/19 4:10 PM, Luis Chamberlain wrote:
> > Hey Hans, thanks for staying on top of this and follow up! For some
> > reason the universe conspired against your first and last patch ([1/8],
> > [8/8]), and I never got them. Could you bounce these or resend in case
> > others confirm they also didn't get it?
> 
> I have received feedback from others on the first patch, so at least
> that one has reached others. I've bounced patches 1 and 8 to you.

Thanks, can you also bounce the feedback received?

  Luis
