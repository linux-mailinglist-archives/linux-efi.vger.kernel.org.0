Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FFFC2F7
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNJsB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfKNJsB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:48:01 -0500
Received: from localhost (unknown [61.58.47.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7A620715;
        Thu, 14 Nov 2019 09:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573724880;
        bh=aENC5+uqOt8x8k+ADiNUuSTlGYJaOZ2quvrGJvqWymA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U77pto+xf9jrnoKspvyzQb985Tr5D5ytMcnOHuYeHgUkP0MblJgFv2wef5vEDJRHQ
         GGVrwmuvD2E1SnpHs+N/qxs0wHt9+Oq7SxovW3t/k/ZOFJmWpjTN+miORfCWjndAJX
         S35KA6XKHK7RYSWfL330CTKrkX7Uj5/wPOlkcI9E=
Date:   Thu, 14 Nov 2019 17:47:58 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH] sysfs: Fixes __BIN_ATTR_WO() macro
Message-ID: <20191114094758.GB631558@kroah.com>
References: <1569973038-2710-1-git-send-email-nayna@linux.ibm.com>
 <47DFxf2Pscz9s7T@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DFxf2Pscz9s7T@ozlabs.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 14, 2019 at 08:07:49PM +1100, Michael Ellerman wrote:
> On Tue, 2019-10-01 at 23:37:18 UTC, Nayna Jain wrote:
> > This patch fixes the size and write parameter for the macro
> > __BIN_ATTR_WO().
> > 
> > Fixes: 7f905761e15a8 ("sysfs: add BIN_ATTR_WO() macro")
> > Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/39a963b457b5c6cbbdc70441c9d496e39d151582

Why?  This is already in 5.4-rc5, why do you need/want it again?

thanks,

greg k-h
