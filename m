Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E30FC243
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKNJIa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:08:30 -0500
Received: from ozlabs.org ([203.11.71.1]:39105 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKNJI2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:28 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyK2l6Jz9sSl; Thu, 14 Nov 2019 20:08:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2702809a4a1ab414d75c00936cda70ea77c8234e
In-Reply-To: <e9eeee6b-b9bf-1e41-2954-61dbd6fbfbcf@linux.ibm.com>
To:     Eric Richter <erichte@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10a 3/9] powerpc: detect the trusted boot state of the system
Message-Id: <47DFyK2l6Jz9sSl@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:24 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2019-11-05 at 23:02:07 UTC, Eric Richter wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> While secure boot permits only properly verified signed kernels to be
> booted, trusted boot calculates the file hash of the kernel image and
> stores the measurement prior to boot, that can be subsequently compared
> against good known values via attestation services.
> 
> This patch reads the trusted boot state of a PowerNV system. The state
> is used to conditionally enable additional measurement rules in the IMA
> arch-specific policies.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2702809a4a1ab414d75c00936cda70ea77c8234e

cheers
