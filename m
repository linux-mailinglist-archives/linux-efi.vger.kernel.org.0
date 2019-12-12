Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B00E11CD29
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 13:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbfLLM3g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 07:29:36 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:38690 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbfLLM3g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 07:29:36 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 60479200A83;
        Thu, 12 Dec 2019 12:29:34 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 5997C20B6C; Thu, 12 Dec 2019 13:29:11 +0100 (CET)
Date:   Thu, 12 Dec 2019 13:29:11 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.5 regression fix 0/2] efi/libstub: Fix mixed-mode crash
 at boot
Message-ID: <20191212122911.GA302343@light.dominikbrodowski.net>
References: <20191212103158.4958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212103158.4958-1-hdegoede@redhat.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 12, 2019 at 11:31:56AM +0100, Hans de Goede wrote:
> Hi All,
> 
> Commit 0d95981438c3 ("x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table")
> causes drivers/efi/libstub/random.c to be used on x86 for the first time
> and some of the code in that file does not deal properly with mixed-mode
> setups causing a crash at boot on mixed-mode devices.
> 
> The first patch in this series fixes this and is the regression-fix from
> $subject.

Sorry for the bug, and thanks for the bugfix!

	Dominik
