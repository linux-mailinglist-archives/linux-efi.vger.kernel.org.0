Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3134AF730
	for <lists+linux-efi@lfdr.de>; Wed,  9 Feb 2022 17:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiBIQuB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Feb 2022 11:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiBIQuA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Feb 2022 11:50:00 -0500
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB774C05CB8F;
        Wed,  9 Feb 2022 08:49:59 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id D0B0740A63; Wed,  9 Feb 2022 16:49:57 +0000 (GMT)
Date:   Wed, 9 Feb 2022 16:49:57 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jlee@suse.com" <jlee@suse.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "mic@digikod.net" <mic@digikod.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [PATCH] efi: Do not import certificates from UEFI Secure Boot
 for T2 Macs
Message-ID: <20220209164957.GB12763@srcf.ucam.org>
References: <9D0C961D-9999-4C41-A44B-22FEAF0DAB7F@live.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9D0C961D-9999-4C41-A44B-22FEAF0DAB7F@live.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 09, 2022 at 02:27:51PM +0000, Aditya Garg wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> On T2 Macs, the secure boot is handled by the T2 Chip. If enabled, only
> macOS and Windows are allowed to boot on these machines. Thus we need to
> disable secure boot for Linux. If we boot into Linux after disabling
> secure boot, if CONFIG_LOAD_UEFI_KEYS is enabled, EFI Runtime services
> fail to start, with the following logs in dmesg

Which specific variable request is triggering the failure? Do any 
runtime variable accesses work on these machines?
