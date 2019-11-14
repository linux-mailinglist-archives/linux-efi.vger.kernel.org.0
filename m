Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7F6FC250
	for <lists+linux-efi@lfdr.de>; Thu, 14 Nov 2019 10:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKNJIK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 Nov 2019 04:08:10 -0500
Received: from ozlabs.org ([203.11.71.1]:44081 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKNJIG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:06 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxw1YRMz9sSM; Thu, 14 Nov 2019 20:08:04 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1917855f4e0658c313e280671ad87774dbfb7b24
In-Reply-To: <1572492694-6520-5-git-send-email-zohar@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v10 4/9] powerpc/ima: define trusted boot policy
Message-Id: <47DFxw1YRMz9sSM@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:04 +1100 (AEDT)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2019-10-31 at 03:31:29 UTC, Mimi Zohar wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> This patch defines an arch-specific trusted boot only policy and a
> combined secure and trusted boot policy.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1917855f4e0658c313e280671ad87774dbfb7b24

cheers
