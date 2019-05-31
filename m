Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A9630A2E
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2019 10:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfEaIX6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 May 2019 04:23:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50543 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIX6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 May 2019 04:23:58 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 59d5adea62202d2a; Fri, 31 May 2019 10:23:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-efi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>, vishal.l.verma@intel.com,
        ard.biesheuvel@linaro.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 1/8] acpi: Drop drivers/acpi/hmat/ directory
Date:   Fri, 31 May 2019 10:23:55 +0200
Message-ID: <4965161.Uu1Nigf0I0@kreacher>
In-Reply-To: <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155925716254.3775979.16716824941364738117.stgit@dwillia2-desk3.amr.corp.intel.com> <155925716783.3775979.13301455166290564145.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Friday, May 31, 2019 12:59:27 AM CEST Dan Williams wrote:
> As a single source file object there is no need for the hmat enabling to
> have its own directory.

Well, I asked Keith to add that directory as the code in hmat.c is more related to mm than to
the rest of the ACPI subsystem.

Is there any problem with retaining it?



