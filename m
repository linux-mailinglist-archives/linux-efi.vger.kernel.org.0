Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BA2B2D17
	for <lists+linux-efi@lfdr.de>; Sat, 14 Nov 2020 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKNMSe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Nov 2020 07:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgKNMSe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Nov 2020 07:18:34 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4946122240;
        Sat, 14 Nov 2020 12:18:32 +0000 (UTC)
Date:   Sat, 14 Nov 2020 12:18:29 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, zohar@linux.ibm.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, will@kernel.org,
        clin@suse.com, x86@kernel.org, jlee@suse.com,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] arm64/ima: add ima_arch support
Message-ID: <20201114121829.GB2837@gaia>
References: <20201102223800.12181-1-ardb@kernel.org>
 <20201102223800.12181-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102223800.12181-4-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 02, 2020 at 11:38:00PM +0100, Ard Biesheuvel wrote:
> From: Chester Lin <clin@suse.com>
> 
> Add arm64 IMA arch support. The code and arch policy is mainly inherited
> from x86.
> 
> Co-developed-by: Chester Lin <clin@suse.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
