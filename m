Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F06C704308
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 03:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjEPBnQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 21:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjEPBnP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 21:43:15 -0400
Received: from cavan.codon.org.uk (irc.codon.org.uk [IPv6:2a00:1098:84:22e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123BD5B9B;
        Mon, 15 May 2023 18:43:12 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 801BD42529; Tue, 16 May 2023 02:43:10 +0100 (BST)
Date:   Tue, 16 May 2023 02:43:10 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 04/14] x86: Secure Launch Resource Table header file
Message-ID: <20230516014310.GA5403@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-5-ross.philipson@oracle.com>
 <20230512105554.GB14461@srcf.ucam.org>
 <30d5891d-4747-8d67-2667-ff07628740bd@apertussolutions.com>
 <20230515212206.GA2162@srcf.ucam.org>
 <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9d1260-41dd-034b-9dc6-14173c6c0d25@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,SPF_HELO_NEUTRAL,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 15, 2023 at 08:41:00PM -0400, Daniel P. Smith wrote:
> On 5/15/23 17:22, Matthew Garrett wrote:
> > What if I don't use grub, but use something that behaves equivalently?
> > Which value should be used here?
> 
> Generally we would request that the bootloader submit a request to register
> for a value to be reserved in the spec. That aside, the intent here is to
> allow for the possibility for the DLE handler to be independent from the
> bootloader, but this does not have to be this way. If a non-open entity
> decides to produce their own implementation, they can freely use a
> unallocated value at their own risk that it could be allocated to another
> bootloader in the future. Though in this scenario it likely would not matter
> as the non-open DLE handler would only be present when the non-open
> bootloader was present.

Is the expectation that the DLE will always be shipped with the 
bootloader? I think I'm not entirely clear on what's consuming this and 
why.

