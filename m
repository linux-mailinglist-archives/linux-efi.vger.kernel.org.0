Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD68332CFF7
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 10:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhCDJpf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Mar 2021 04:45:35 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:47223 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbhCDJpF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Mar 2021 04:45:05 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A79552800B3CD;
        Thu,  4 Mar 2021 10:44:20 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9B404FEC78; Thu,  4 Mar 2021 10:44:20 +0100 (CET)
Date:   Thu, 4 Mar 2021 10:44:20 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/apple-properties: Handle device properties with
 software node API
Message-ID: <20210304094420.GA25266@wunner.de>
References: <20210304082837.22262-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304082837.22262-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 04, 2021 at 11:28:37AM +0300, Heikki Krogerus wrote:
> The old device property API is going to be removed.
> Replacing the device_add_properties() call with the software
> node API equivalent, device_create_managed_software_node().
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Lukas Wunner <lukas@wunner.de>
