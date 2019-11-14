Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C203AFC253
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKNJHx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:07:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfKNJHw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:52 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxf2Pscz9s7T; Thu, 14 Nov 2019 20:07:49 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 39a963b457b5c6cbbdc70441c9d496e39d151582
In-Reply-To: <1569973038-2710-1-git-send-email-nayna@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: Re: [PATCH] sysfs: Fixes __BIN_ATTR_WO() macro
Message-Id: <47DFxf2Pscz9s7T@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:49 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2019-10-01 at 23:37:18 UTC, Nayna Jain wrote:
> This patch fixes the size and write parameter for the macro
> __BIN_ATTR_WO().
> 
> Fixes: 7f905761e15a8 ("sysfs: add BIN_ATTR_WO() macro")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39a963b457b5c6cbbdc70441c9d496e39d151582

cheers
