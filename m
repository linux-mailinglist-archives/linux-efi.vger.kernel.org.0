Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB709E9C8
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2019 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfH0NpN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 27 Aug 2019 09:45:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43753 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0NpN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 27 Aug 2019 09:45:13 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2bmC-0006fx-GB; Tue, 27 Aug 2019 15:44:48 +0200
Date:   Tue, 27 Aug 2019 15:44:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        james.morse@arm.com, rjw@rjwysocki.net,
        Tony Luck <tony.luck@intel.com>, linuxarm@huawei.com,
        ard.biesheuvel@linaro.org, nariman.poushin@linaro.org,
        Jon Masters <jcm@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, peter.maydell@linaro.org,
        linux-spdx@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6 V2] CCIX Protocol error reporting.
In-Reply-To: <20190820144732.2370-1-Jonathan.Cameron@huawei.com>
Message-ID: <alpine.DEB.2.21.1908271539590.1939@nanos.tec.linutronix.de>
References: <20190820144732.2370-1-Jonathan.Cameron@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-891169229-1566913488=:1939"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-891169229-1566913488=:1939
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Jonathan,

On Tue, 20 Aug 2019, Jonathan Cameron wrote:

Cc+ linux-spdx@vger.kernel.org

> The following boilerplate is granting rights to the kernel.
> Note that I haven't applied the CCIX copyright notice anywhere in this
> series because we aren't quoting from the specification.  That is
> much more likely to happen in documentation patches than in code.
> 
> Like anything else in this series it is open to comment.
> 
> This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> you and other parties that are participating (the "participants") in the
> Linux kernel with the understanding that the participants will use CCIX's
> name and trademark only when this patch is used in association with the
> Linux kernel and associated user space.

The code is licensed under GPLV2, so what precludes any other GPLV2 project
to import that code?

If there is a mentioning of CCIX Consortium in the imported code then you
cannot impose that this needs to be removed because it ends up in something
which is neither Linux kernel nor associated user space. And that's
especially true when this ends up being a copyright notice.
 
> CCIX is also distributing this patch to these participants with the
> understanding that if any portion of the CCIX specification will be
> used or referenced in the Linux kernel, the participants will not modify
> the cited portion of the CCIX specification and will give CCIX proper
> copyright attribution by including the following copyright notice with
> the cited part of the CCIX specification:
> "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."

Just to prove the point.

Thanks,

	tglx
--8323329-891169229-1566913488=:1939--
