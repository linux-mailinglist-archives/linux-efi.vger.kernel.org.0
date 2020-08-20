Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692EB24B52E
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgHTKUa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Aug 2020 06:20:30 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:6917 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbgHTKUZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Aug 2020 06:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597918825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Sv68RoNLXVff/6n8GJVDTzUndQIzSGsto9tYosUgXbw=;
  b=AznunsBUonXknv9jqFhp3YXSxxZ1uxt+H2KvV61dWsm3G53n7J9AZfB1
   qI5+ZDDA2P2NSnYRnXsek+Mw1LrafRrGJ/GzDe9OYYJTzOq6F5tXg5Cum
   gFvG5mX5UVjPLVpFrvTPq9CfnVmyHE5f/Mqv16VHSh2ZO3g3qs5XjbrxI
   4=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: g5He4ply494ZRa/EGg7MaC71UzA0BjHI1c7YSwZBTDzTp9vpey0jdtGIFSsbMxA1X6JsEBAvkw
 B26jNrEgbiFdR1wvCVK0z3EhFmTTq4XgjmQ4hJTQKN/YHmJkqr3oqEq7fo7nByDE/78nF//jET
 ail+DgQVD5LgeIS6TGXJHGPHn3r/NmlyoYNxzeNv9wZ5nmrHZHIqKJpLTa/azaYJygb0agovIt
 sOBNqo3hgPUzC/dFP+lUPEmbSTg+MmbWcdS+RPQkTjx3SN4flHaKnhszEvO84y4Le8Yy5jVL1n
 qaI=
X-SBRS: 2.7
X-MesageID: 24943558
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,332,1592884800"; 
   d="scan'208";a="24943558"
Date:   Thu, 20 Aug 2020 12:20:16 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
CC:     Norbert Kaminski <norbert.kaminski@3mdeb.com>,
        Ard Biesheuvel <ardb@kernel.org>, <linux-efi@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maciej Pijanowski <maciej.pijanowski@3mdeb.com>,
        <piotr.krol@3mdeb.com>
Subject: Re: [PATCH] efi: discover ESRT table on Xen PV too
Message-ID: <20200820102016.GU828@Air-de-Roger>
References: <20200817090013.GN975@Air-de-Roger>
 <20200818120135.GK1679@mail-itl>
 <20200818124710.GK828@Air-de-Roger>
 <20200818150020.GL1679@mail-itl>
 <20200818172114.GO828@Air-de-Roger>
 <20200818184018.GN1679@mail-itl>
 <20200819081930.GQ828@Air-de-Roger>
 <3d405b0c-4e2b-0d29-56bb-e315f4c21d03@3mdeb.com>
 <20200820093025.GT828@Air-de-Roger>
 <20200820093454.GS1626@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820093454.GS1626@mail-itl>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 20, 2020 at 11:34:54AM +0200, Marek Marczykowski-Górecki wrote:
> On Thu, Aug 20, 2020 at 11:30:25AM +0200, Roger Pau Monné wrote:
> > Right, so you only need access to the ESRT table, that's all. Then I
> > think we need to make sure Xen doesn't use this memory for anything
> > else, which will require some changes in Xen (or at least some
> > checks?).
> > 
> > We also need to decide what to do if the table turns out to be placed
> > in a wrong region. How are we going to prevent dom0 from using it
> > then? My preference would be to completely hide it from dom0 in that
> > case, such that it believes there's no ESRT at all if possible.
> 
> Yes, that makes sense. As discussed earlier, that probably means
> re-constructing SystemTable before giving it to dom0. We'd need to do
> that in PVH case anyway, to adjust addresses, right?

Not really, on PVH dom0 we should be able to identity map the required
EFI regions in the dom0 p2m, so the only difference between a classic
PV dom0 is that we need to assure that those regions are correctly
identity mapped in the p2m, but that shouldn't require any change to
the SystemTable unless we need to craft custom tables (see below).

> Is there something
> like this in the Xen codebase already, or it needs to be written from
> scratch?

AFAICT it needs to be written for EFI. For the purposes here I think
you could copy the SystemTable and modify the NumberOfTableEntries and
ConfigurationTable fields in the copy in order to delete the ESRT if
found to be placed in a non suitable region?

At that point we can remove the checks from Linux since Xen will
assert that whatever gets passed to dom0 is in a suitable region. It
would be nice to have a way to signal that the placement of the ESRT
has been checked, but I'm not sure how to do this, do you have any
ideas?

Roger.
