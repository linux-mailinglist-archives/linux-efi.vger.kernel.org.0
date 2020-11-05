Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED2A2A7AA2
	for <lists+linux-efi@lfdr.de>; Thu,  5 Nov 2020 10:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgKEJd0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Nov 2020 04:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKEJdZ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Nov 2020 04:33:25 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1B22080D;
        Thu,  5 Nov 2020 09:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604568805;
        bh=3esBga4idpU2CSztj4UZCUzqnXaLovO1PuuzPUcV1Io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGGNaoA+V5Tdop3BsgFeg6nWP7EKfSbL3+02OpMkimQT9S4v6genkjnCeoZNQ9RxB
         hACOVnqzOA8mq0q2aaY24jKKTfohJPg9W4APW/5zwtNubLJoswG1Zan7RP6/9Rx+qu
         VrTCOw2+C0C9E9gY5H7OPnNNYKwHCGzaUUBmLHyg=
Date:   Thu, 5 Nov 2020 10:34:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 01/18] Revert "driver core: Avoid deferred probe due
 to fw_devlink_pause/resume()"
Message-ID: <20201105093413.GC3439341@kroah.com>
References: <20201104232356.4038506-1-saravanak@google.com>
 <20201104232356.4038506-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104232356.4038506-2-saravanak@google.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 04, 2020 at 03:23:38PM -0800, Saravana Kannan wrote:
> This reverts commit 2451e746478a6a6e981cfa66b62b791ca93b90c8.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

You need to say _why_ you are doing this, it's obvious _what_ you are
doing :)

Same for the other reverts in this series.

thanks,

greg k-h
