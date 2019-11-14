Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B28FC22F
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKNJI2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:08:28 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:59753 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfKNJI1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:27 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyH4L62z9sPT; Thu, 14 Nov 2019 20:08:23 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1a8916ee3ac29054322cdac687d36e1b5894d272
In-Reply-To: <46b003b9-3225-6bf7-9101-ed6580bb748c@linux.ibm.com>
To:     Eric Richter <erichte@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10a 1/9] powerpc: detect the secure boot mode of the system
Message-Id: <47DFyH4L62z9sPT@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:23 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2019-11-05 at 23:00:22 UTC, Eric Richter wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> This patch defines a function to detect the secure boot state of a
> PowerNV system.
> 
> The PPC_SECURE_BOOT config represents the base enablement of secure boot
> for powerpc.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1a8916ee3ac29054322cdac687d36e1b5894d272

cheers
