Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80192704312
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 03:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEPBpy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 21:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEPBpx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 21:45:53 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8846B4;
        Mon, 15 May 2023 18:45:50 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 7F4FC42529; Tue, 16 May 2023 02:45:49 +0100 (BST)
Date:   Tue, 16 May 2023 02:45:49 +0100
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
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Message-ID: <20230516014549.GB5403@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
 <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
 <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 15, 2023 at 09:11:15PM -0400, Daniel P. Smith wrote:
> On 5/12/23 12:17, Ross Philipson wrote:
> > This is a good point. At this point it is really something we
> > overlooked. We will have to revisit this and figure out the best way to
> > find the final event log depending on how things booted.
> 
> I believe Ross misunderstood what you were asking for here. There are two
> reasons this is not possible or desired. The first reason is that on Intel,
> the DRTM log is not initialized by TrenchBoot code in the preamble. It is
> only responsible for allocating a buffer and recording the location in the
> TXT structures. When the SINIT ACM is executed, it will initialize the log
> and record the measurement that CPU sent directly to the TPM and then the
> measurements the ACM makes of the environment. If you pointed at the SRTM
> log, then the ACM would write over existing log, which I don't think you
> want. Now if you pointed at the tail end of the SRTM log, you would still
> end up with a second, separate log that just happens to be memory adjacent.

Ok. I think it would be clearer if either the function names or some 
comments expressly indicated that this refers to the DRTM event log and 
that that's a separate entity from the SRTM one, "event log" on its own 
is likely to cause people to think of the existing log rather than 
associate it with something else.
