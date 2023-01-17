Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4D66E4A2
	for <lists+linux-efi@lfdr.de>; Tue, 17 Jan 2023 18:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjAQRQM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Jan 2023 12:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjAQRPf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Jan 2023 12:15:35 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6C4B184
        for <linux-efi@vger.kernel.org>; Tue, 17 Jan 2023 09:14:58 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 350A6424A2; Tue, 17 Jan 2023 17:14:57 +0000 (GMT)
Date:   Tue, 17 Jan 2023 17:14:57 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] efi: Remove Matthew Garrett as efivarfs maintainer
Message-ID: <20230117171457.GA11696@srcf.ucam.org>
References: <20230117170742.1461185-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117170742.1461185-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 17, 2023 at 06:07:42PM +0100, Ard Biesheuvel wrote:
> Matthew Garrett is still listed as a efivarfs co-maintainer, but the
> email address bounces, and Matt is no longer involved in maintaining
> this code.
> 
> So let's remove Matt as a efivarfs co-maintainer from MAINTAINERS.
> Thanks for all the hard work!
> 
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

ACKed-by: Matthew Garrett <mjg59@srcf.ucam.org>
